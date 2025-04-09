// lib/core/utils/tenant_scanner.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/concierge/Home/widget/select_tenant_widget.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';

class TenantScanner {
  final String type;
  final List<ConciergeTenant> allTenants;
  final VoidCallback onParcelCountChanged;

  TenantScanner({
    required this.allTenants,
    required this.type,
    required this.onParcelCountChanged,
  });

  Future<void> scanAndMatch({
    required BuildContext context,
    required String imagePath,
    required void Function(ConciergeTenant selectedTenant) onTenantSelected,
  }) async {
    final selectedImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(selectedImage);
    await textRecognizer.close();

    final scannedWords = recognizedText.blocks
        .expand((block) => block.lines)
        .expand((line) => line.text.split(" "))
        .map((word) => word.toLowerCase())
        .toSet();

    final matchedTenants = allTenants.where((tenant) {
      final name = tenant.info?.firstName?.toLowerCase() ?? '';
      return name.isNotEmpty && scannedWords.any((word) => word.contains(name));
    }).toList();

    if (matchedTenants.isNotEmpty) {
      await SelectTenantWidget.showAsBottomSheet(
        context: context,
        matchedTenants: matchedTenants,
        onTenantSelected: onTenantSelected,
        onTenantInfoTapped: (tenant) {
          context.router.push(
              ConciergeTenantDetailsRoute(conciergeTenant: tenant, type: type, onCountUpdated: onParcelCountChanged));
        },
      );
    } else {
      alertManager.showError(
        context,
        "No match found with predefined tenants.",
      );
    }
  }
}
