import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:impero_it_assessment/core/network/network_exception.dart';
import 'package:impero_it_assessment/core/services/local_storage_service.dart';

/// Utility class for network-related operations.
/// Provides common functionality for HTTP headers and response handling.
class NetworkUtils {
  static String? _cachedToken;
  String token;

  // Private constructor
  NetworkUtils._internal(this.token);

  /// Returns the default headers used for HTTP requests
  ///
  /// Returns a Map containing:
  /// - Content-Type: application/json
  /// - Accept: application/json
  /// - Authorization: Bearer token
  static Future<Map<String, String>> defaultHeaders() async {
    // Use cached token if available, otherwise fetch it
    String tokenToUse = _cachedToken ?? LocalStorageService.getToken();
    _cachedToken = tokenToUse; // Update the cache

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenToUse',
    };
  }

  /// Returns the default headers used for HTTP requests synchronously
  /// Returns a Map containing:
  /// - Content-Type: application/json
  /// - Accept: application/json
  /// - Authorization: Bearer token
  static Map<String, String> defaultHeadersSync() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_cachedToken ?? ''}',
    };
  }

  static Map<String, dynamic> handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final Map<String, dynamic> json = jsonDecode(response.body);

    if (statusCode >= 200 && statusCode < 300) {
      return json;
    } else {
      throw NetworkException(statusCode: statusCode, message: json['message'] ?? 'Unknown error');
    }
  }
}
