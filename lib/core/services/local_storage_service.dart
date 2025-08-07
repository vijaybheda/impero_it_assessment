import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:impero_it_assessment/navigation/getx_navigation.dart';

class LocalStorageService {
  static const String _tokenKey = 'token';
  static const String _storageKeyName = 'impero_it_assessment';
  static late GetStorage _storage;

  // Initialize the storage
  static Future<void> init() async {
    await GetStorage.init(_storageKeyName);
    _storage = GetStorage(_storageKeyName);
  }

  static void setToken(String token) {
    _storage.write(_tokenKey, token);
  }

  static String getToken() {
    return _storage.read(_tokenKey) ?? "";
  }

  static Future<void> logout(String message) async {
    String token = getToken();
    if (token.isEmpty) {
      return;
    }
    await _storage.erase();
    if (message.isNotEmpty) {
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    GetxNavigation().navigateToNextAndRemovePreviousAll('/');
  }
}
