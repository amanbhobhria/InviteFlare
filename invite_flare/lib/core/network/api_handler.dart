import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:if_loop_components/utils/if_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/core/exceptions/app_exception.dart';
import 'package:invite_flare/core/exceptions/error_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class APIHandler {
  final String baseUrl = getIt<String>();
  final http.Client httpClient = getIt<http.Client>();

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  /// Perform a GET request
  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async =>
      await _request(
        endpoint,
        method: 'GET',
        headers: headers,
        queryParameters: queryParameters,
      );

  /// Perform a POST request
  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async =>
      await _request(
        endpoint,
        method: 'POST',
        headers: headers,
        body: body,
        queryParameters: queryParameters,
      );

  /// Perform a PUT request
  Future<http.Response> put(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async =>
      await _request(
        endpoint,
        method: 'PUT',
        headers: headers,
        body: body,
        queryParameters: queryParameters,
      );

  /// Perform a DELETE request
  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async =>
      await _request(
        endpoint,
        method: 'DELETE',
        headers: headers,
        queryParameters: queryParameters,
      );

  /// Core request handler with HTTP Interceptor
  Future<http.Response> _request(
    String endpoint, {
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async {
    // Intercept and modify the request before sending
    headers = await _addDefaultHeaders(headers);
    final uri = _buildUri(endpoint, queryParameters);
    _logRequest(uri, method, body: body, headers: headers);

    try {
      http.Response response;

      switch (method) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          response =
              await http.post(uri, headers: headers, body: json.encode(body));
          break;
        case 'PUT':
          response =
              await http.put(uri, headers: headers, body: json.encode(body));
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw Exception('Unsupported HTTP method');
      }

      _logResponse(response);

      if (response.statusCode >= 400 && response.statusCode < 500) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        String? errorMsg =
            jsonData.containsKey('errorMsg') ? jsonData['errorMsg'] : null;
        errorMsg ??= jsonData.containsKey('error') ? jsonData['error'] : null;
        errorMsg = _getExceptionMessage(response.statusCode, errorMsg);
        throw ClientException(errorMsg);
      } else if (response.statusCode >= 500) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        String? errorMsg =
            jsonData.containsKey('message') ? jsonData['message'] : null;
        errorMsg ??=
            jsonData.containsKey('message') ? jsonData['message'] : null;
        errorMsg = _getExceptionMessage(response.statusCode, errorMsg);

        throw InternalServerException(errorMsg);
      }

      if (response.statusCode == 401) {
        logPrint('Access token expired. Attempting to refresh token...');
        final refreshed = await _refreshToken();
        if (refreshed) {
          logPrint('Access token refreshed. Retrying request...');
          headers['Authorization'] = 'Bearer ${await _getAccessToken()}';
          return _request(endpoint,
              method: method,
              headers: headers,
              body: body,
              queryParameters: queryParameters);
        } else {
          logPrint('Token refresh failed.');
        }
      }

      return response;
    } on SocketException catch (e) {
      throw NetworkException(e.message);
    } on ClientException {
      rethrow;
    } on InternalServerException {
      rethrow;
    } on FormatException catch (e) {
      logPrint('FormatException: $e');
      throw Exception('Invalid response format: $e');
    } on Exception catch (e) {
      logPrint('Unknown Exception: $e');
      throw Exception('An error occurred: $e');
    }
  }

  /// Add default headers through HTTP Interceptor
  Future<Map<String, String>> _addDefaultHeaders(
    Map<String, String>? headers,
  ) async {
    headers ??= {};
    headers['Content-Type'] = 'application/json';
    final accessToken = await _getAccessToken();
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  /// Build URI with Query Parameters
  Uri _buildUri(
    String endpoint,
    Map<String, String>? queryParameters,
  ) {
    Uri uri = Uri.parse('$baseUrl$endpoint');
    if (queryParameters != null && queryParameters.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParameters);
    }
    return uri;
  }

  /// Refresh the access token
  Future<bool> _refreshToken() async {
    String? refreshToken = await _getRefreshToken();

    if (refreshToken == null) {
      logPrint('No refresh token found.');
      return false;
    }

    try {
      final Uri url = Uri.parse('$baseUrl/auth/refresh');
      final response = await http.post(
        url,
        body: json.encode({'refresh_token': refreshToken}),
        headers: {'Content-Type': 'application/json'},
      );

      logPrint(
          'Refresh Token Response (${response.statusCode}): ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        await _setAccessToken(data['accessToken']);
        await _setRefreshToken(data['refreshToken']);

        logPrint('Tokens updated successfully.');
        return true;
      } else {
        logPrint('Refresh token invalid. Clearing stored tokens.');
        final prefs = await _prefs();
        await prefs.remove('access_token');
        await prefs.remove('refresh_token');
        return false;
      }
    } catch (e) {
      logPrint('Token refresh failed: $e');
      throw Exception('Token refresh failed: $e');
    }
  }

  /// Clear stored tokens (useful for logout)
  Future<void> clearTokens() async {
    logPrint('Clearing stored tokens...');
    final prefs = await _prefs();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    logPrint('Token vanished successfully!!');
  }

  /// Helper function for logging
  void logPrint(String message) {
    IFLogger.info(message: message, tag: 'API');
  }

  /// Helper method to get SharedPreferences instance
  Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  /// Get the access token
  Future<String?> _getAccessToken() async {
    final prefs = await _prefs();
    return prefs.getString('access_token');
  }

  /// Get the refresh token
  Future<String?> _getRefreshToken() async {
    final prefs = await _prefs();
    return prefs.getString('refresh_token');
  }

  /// Save the access token
  Future<void> _setAccessToken(String token) async {
    final prefs = await _prefs();
    await prefs.setString('access_token', token);
  }

  /// Save the refresh token
  Future<void> _setRefreshToken(String token) async {
    final prefs = await _prefs();
    await prefs.setString('refresh_token', token);
  }

  final _indent = '';

  void _logRequest(
    Uri url,
    String method, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, String>? multipartFields,
    List<http.MultipartFile>? multipartFiles,
  }) {
    IFLogger.newLine();
    logPrint('API_$method ----> $url');
    if (method == 'POST' || method == 'PUT') {
      if (body != null) {
        logPrint('${_indent}REQUEST_BODY: ${json.encode(body)}');
      }

      if (method == 'POST') {
        if (multipartFields != null) {
          logPrint('${_indent}MultipartFields: $multipartFields');
        }
        if (multipartFiles != null) {
          logPrint('${_indent}MultipartFiles: $multipartFiles');
        }
      }
    }
    logPrint('${_indent}HEADERS: $headers\n');
  }

  void _logResponse(http.Response response) {
    IFLogger.newLine();
    logPrint('RESPONSE ${response.statusCode} <---- ${response.request}');
    logPrint('BODY_BYTES: ${response.bodyBytes.length}');
    try {
      logPrint('RESPONSE_BODY: ${response.body}\n');
    } catch (_) {}
  }

  String _getExceptionMessage(int statusCode, String? message) {
    switch (statusCode) {
      case 400:
        String errorMsg = message ?? ErrorMessage.code400;
        IFLogger.error(message: errorMsg);
        return errorMsg;
      case 401:
        String errorMsg = message ?? ErrorMessage.code401;
        IFLogger.error(message: errorMsg);
        return errorMsg;
      case 403:
        String errorMsg = message ?? ErrorMessage.code403;
        IFLogger.error(message: errorMsg);
        return errorMsg;
      case 404:
        String errorMsg = message ?? ErrorMessage.code404;
        IFLogger.error(message: errorMsg);
        return errorMsg;
      case 429:
        String errorMsg = message ?? ErrorMessage.code429;
        IFLogger.error(message: errorMsg);
        return errorMsg;
      case 500:
        String errorMsg = message ?? ErrorMessage.code500;
        IFLogger.error(message: errorMsg);
        return errorMsg;
      case 502:
        String errorMsg = message ?? ErrorMessage.code502;
        IFLogger.error(message: errorMsg);
        return errorMsg;
      case 503:
        String errorMsg = message ?? ErrorMessage.code503;
        IFLogger.error(message: errorMsg);
        return errorMsg;
      case 504:
        String errorMsg = message ?? ErrorMessage.code504;
        IFLogger.error(message: errorMsg);
        return errorMsg;
      default:
        return ErrorMessage.unknownCode;
    }
  }
}
