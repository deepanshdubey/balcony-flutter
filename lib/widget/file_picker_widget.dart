import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerWidget extends StatelessWidget {
  final Widget child;
  final Function(String) onFileSelected;

  FilePickerWidget({
    required this.onFileSelected,
    required this.child,
  });

  Future<void> pickFile(BuildContext context) async {
    // Check for permission

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      onFileSelected(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => pickFile(context), child: child);
  }
}
