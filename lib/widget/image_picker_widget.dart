import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
        // Open WeChat-style image picker
        final List<AssetEntity>? result = await AssetPicker.pickAssets(
          context,
          pickerConfig: AssetPickerConfig(
            maxAssets: 1, // Allow only one image selection
            requestType: RequestType.image, // Only pick images
          ),
        );

        if (result != null && result.isNotEmpty) {
          final File? file = await result.first.file;
          if (file != null) {
            onImageSelected(file.path);
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
