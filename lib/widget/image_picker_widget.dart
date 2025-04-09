import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework/widget/app_outlined_button.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final ImageSource source;
  final Function(String) onImageSelected;
  final Widget? child;
  final Widget Function(VoidCallback pickImage)? builder;

  const ImagePickerWidget({
    super.key,
    required this.onImageSelected,
    this.source = ImageSource.gallery,
    this.child,
    this.builder,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();

  static Future<void> showSourceSheet({
    required BuildContext context,
    required Function(String path) onImageSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        final textStyle = Theme.of(context).textTheme.titleLarge;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Choose',
                  style: textStyle?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              ImagePickerWidget(
                source: ImageSource.camera,
                onImageSelected: (path) {
                  Navigator.pop(context);
                  onImageSelected(path);
                },
                builder: (pickImage) => AppOutlinedButton(
                  text: "Camera",
                  onPressed: pickImage,
                ),
              ),
              ImagePickerWidget(
                source: ImageSource.gallery,
                onImageSelected: (path) {
                  Navigator.pop(context);
                  onImageSelected(path);
                },
                builder: (pickImage) => PrimaryButton(
                  onPressed: pickImage,
                  text: "gallery",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  Future<void> pickImage() async {
    try {
      if (Platform.isIOS && widget.source == ImageSource.gallery) {
        final List<AssetEntity>? result = await AssetPicker.pickAssets(
          context,
          pickerConfig: const AssetPickerConfig(
            maxAssets: 1,
            requestType: RequestType.image,
          ),
        );

        if (result != null && result.isNotEmpty) {
          final File? file = await result.first.file;
          if (file != null) {
            widget.onImageSelected(file.path);
          }
        }
      } else {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: widget.source);

        if (image != null) {
          widget.onImageSelected(image.path);
        }
      }
    } catch (error, stacktrace) {
      debugPrint("Error picking image: $error\n$stacktrace");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null) {
      return widget.builder!(pickImage);
    }

    return GestureDetector(
      onTap: pickImage,
      child: widget.child ?? const SizedBox.shrink(),
    );
  }
}
