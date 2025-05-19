import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarUtil {
  static void showSuccess({required String message}) {
    Get.closeAllSnackbars();
    Get.rawSnackbar(
      title: 'success'.tr,
      message: message,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green.shade600,
    );
  }

  static void showWarning({required String message}) {
    Get.closeAllSnackbars();
    Get.rawSnackbar(
      title: 'warning'.tr,
      message: message,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.orange.shade900,
    );
  }

  static void showError({required String message}) {
    Get.closeAllSnackbars();
    Get.rawSnackbar(
      title: 'error',
      message: message,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.redAccent.shade700,
    );
  }
}