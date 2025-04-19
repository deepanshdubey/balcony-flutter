import 'dart:io';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/create_msg_response.dart';
import 'package:homework/data/repository/chat_repository.dart';
import 'package:homework/data/repository/user_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;


part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  @observable
  CommonData? allConversationResponse;


  @observable
  CommonData? startConversationResponse;

  @observable
  CommonData? allMsgResponse;


  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future getAllConversations() async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await chatRepository.getAllConversations();
      if (response.isSuccess) {
        allConversationResponse = response.data;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future startConversations(Map<String , dynamic> request) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await chatRepository.startConversation(request);
      if (response.isSuccess) {
        startConversationResponse = response.data;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future getAllMsg(String conversationId) async {
    try {
      errorMessage = null;
      isLoading = true;
      final response = await chatRepository.getAllMsg(conversationId);
      if (response.isSuccess) {
        allMsgResponse = response.data;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
/*
  @action
  Future createMsgMedia({File? media, required String conversationId, String? type}) async {
    try {
      errorMessage = null;
      isLoading = true;

      final Future<String> imageUploadFuture = _processSingleFilePath(media!.path);

      String url = await imageUploadFuture;

      var payload = {
        "conversationId": conversationId,
        "type": type,
        "url": url,
      };

      final response = await chatRepository.createMessageV2(payload);
      if (response.isSuccess) {
        createMsgResponse = response.data;
      } else {
        errorMessage = response.error!.message;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }*/




  Future<String> _processSingleFilePath(String filePathOrUrl) async {
    if (filePathOrUrl.startsWith('http')) {
      return filePathOrUrl;
    }

    // Call generateS3url API
    var fileExtension = filePathOrUrl.split('.').last;
    var generateS3urlResponse =
    await userRepository.generateS3Url(fileExtension, "chat");

    if (generateS3urlResponse.isSuccess) {
      var signedUrl = generateS3urlResponse.data!.signedUrl!;
      var publicUrl = generateS3urlResponse.data!.publicUrl!;
      await uploadFileToS3(filePathOrUrl, signedUrl);
      // Return public URL
      return publicUrl;
    } else {
      throw Exception(
          "Failed to generate S3 URL: ${generateS3urlResponse.error?.message}");
    }
  }

// Helper to upload file to S3
  Future<void> uploadFileToS3(String filePath, String signedUrl) async {
    var file = File(filePath);
    var bytes = await file.readAsBytes();

    var response = await http.put(
      Uri.parse(signedUrl),
      headers: {
        "Content-Type": "application/octet-stream",
      },
      body: bytes,
    );

    if (response.statusCode != 200) {
      throw Exception("File upload failed: ${response.statusCode}");
    }
  }
}
