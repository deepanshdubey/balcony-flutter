import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    // Check for permission
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      onImageSelected(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => _pickImage(context), child: child);
  }
}
