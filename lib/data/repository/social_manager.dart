// Define the enum for social platforms
import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/data/model/response/common_data.dart';

enum SocialPlatform { google, facebook, apple }

// Abstract class
abstract class SocialManager {
  // Abstract method to login with a social platform
  Future<ApiResponse<CommonData>> loginWithSocial(SocialPlatform platform);
}
