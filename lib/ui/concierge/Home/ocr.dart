import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    const MaterialApp(
      home: OCRIntegrationExample(),
    ),
  );
}

class OCRIntegrationExample extends StatefulWidget {
  const OCRIntegrationExample({Key? key}) : super(key: key);

  @override
  State<OCRIntegrationExample> createState() => _OCRIntegrationExampleState();
}

class _OCRIntegrationExampleState extends State<OCRIntegrationExample> {
  final List<String> predefinedStrings = [
    "about us",
    "terms of service",
    "privacy policy",
    "faq",
    "become a workspace host",
    "become a property host",
  ];

  List<String> scannedTextList = [];
  bool isMatch = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> getRecognizer(XFile img, bool? isList) async {
    final selectedImage = InputImage.fromFilePath(img.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognizedText = await textRecognizer.processImage(selectedImage);
    await textRecognizer.close();
    setState(() {
      scannedTextList = [];
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          scannedTextList.add(line.text);
        }
      }
      isMatch = predefinedStrings.any((string) => scannedTextList.any((text) => text.contains(string)));
    });

    if (isMatch) {
      callAPI();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No match found with predefined strings.")),
      );
    }
  }

  void callAPI() {
    // Simulated API call for demonstration
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("API called successfully!")),
    );
  }

  Future<void> performOCR(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return;
      await getRecognizer(image, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OCR failed: $e")),
      );
    }
  }

  void showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      builder: (BuildContext context) {
        final items = ['Camera', 'Gallery'];

        return ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(
                index == 0 ? Icons.camera_alt_outlined : Icons.photo_library_outlined,
              ),
              title: Text(items[index]),
              onTap: () async {
                await performOCR(index == 0 ? ImageSource.camera : ImageSource.gallery);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter OCR App"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showImageSourceSheet,
        label: const Text("Add image"),
        icon: const Icon(Icons.add_outlined),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: scannedTextList.isEmpty
            ? const Text(
          "No image selected. Use the button to scan text from an image.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recognized Text:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...scannedTextList.map(
                  (line) => Text(
                line,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
