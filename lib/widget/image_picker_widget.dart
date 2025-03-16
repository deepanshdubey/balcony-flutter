import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagePickerWidget extends StatelessWidget {
  final Widget child;
  final ImageSource source;
  final Function(String) onImageSelected;

  ImagePickerWidget({
    required this.onImageSelected,
    this.source = ImageSource.gallery,
    required this.child,
  });

  Future<void> _pickImage(BuildContext context) async {
    try {
      if (Platform.isIOS) {
        // Request permission for iOS
        final PermissionState permission = await PhotoManager.requestPermissionExtend();
        if (!permission.hasAccess) {
          return;
        }

        final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.image);
        if (albums.isNotEmpty) {
          final List<AssetEntity> images = await albums.first.getAssetListRange(start: 0, end: 1);
          if (images.isNotEmpty) {
            final File? file = await images.first.file;
            if (file != null) {
              onImageSelected(file.path);
            }
          }
        }
      } else {
        // Use image_picker for Android
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: source);

        if (image != null) {
          onImageSelected(image.path);
        }
      }
    } catch (error, stacktrace) {
      debugPrint("Error picking image: $error\n$stacktrace");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => _pickImage(context), child: child);
  }
}
