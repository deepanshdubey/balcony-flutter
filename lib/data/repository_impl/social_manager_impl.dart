import 'dart:async';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/user_data.dart';
import 'package:homework/data/repository/social_manager.dart';
import 'package:homework/data/repository/user_repository.dart';
import 'package:homework/values/extensions/map_ext.dart';

class SocialManagerImplementation extends SocialManager {
  final userRepository = locator<UserRepository>();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    serverClientId:
        "254534505135-qm51p5pg2rqbq0t0mtvv6kuk8ah2jjff.apps.googleusercontent.com",
  );

  @override
  Future<ApiResponse<CommonData>> loginWithSocial(
      SocialPlatform platform) async {
    switch (platform) {
      case SocialPlatform.google:
        return await _loginWithGoogle();
      case SocialPlatform.facebook:
        throw UnimplementedError();
      case SocialPlatform.apple:
        throw UnimplementedError();
    }
  }

  Future<ApiResponse<CommonData>> _loginWithGoogle() async {
    try {
      // Attempt to sign in the user
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("User cancelled the Google login process.");
      }

      // Retrieve the user's details
      final String email = googleUser.email;
      final String? displayName = googleUser.displayName;
      final String? profileImage = googleUser.photoUrl;
      final String? password = googleUser.id;

      var user = UserData(
        firstName: displayName?.split(" ").firstOrNull,
        lastName: displayName?.split(" ").elementAtOrNull(1),
        email: email,
        image: profileImage,
        password: password,
      );

      var response = await userRepository.socialAuth(user.toJson().dropNull());

      if (response.isSuccess) {
        return response;
      } else {
        throw response.error!;
      }
    } catch (e) {
      print("Google login failed: $e");
      rethrow;
    }
  }

  Future<ApiResponse<CommonData>> _loginWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        // Fetch the user data
        final userData = await FacebookAuth.instance.getUserData(
          fields: "id, name, email, picture.width(200)",
        );

        final String? displayName = userData["name"];
        final String? email = userData["email"];
        final String? profileImage = userData["picture"]["data"]["url"];
        final String? password = userData["id"];

        var user = UserData(
          id: userData["id"],
          firstName: displayName?.split(" ").firstOrNull,
          lastName: displayName?.split(" ").elementAtOrNull(1),
          email: email,
          image: profileImage,
          password: password,
        );

        var response = await userRepository.socialAuth(user.toJson());

        if (response.isSuccess) {
          return response;
        } else {
          throw response.error!;
        }
      } else if (result.status == LoginStatus.cancelled) {
        throw Exception("User cancelled the Facebook login process.");
      } else {
        throw Exception("Facebook login failed: ${result.message}");
      }
    } catch (e) {
      print("Facebook login failed: $e");
      rethrow;
    }
  }
}
