import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/core_2/core/values/app_global_values.dart';
import 'package:invite_flare/core_2/data/local_service/local_keys.dart';
import 'package:invite_flare/core_2/logger/log_interceptor.dart'
    as LogInterceptor;

const _defaultConnectTimeout = Duration(seconds: 30);
const _defaultReceiveTimeout = Duration(seconds: 30);

String setContentType() => "application/json";

class DioClient {
  static const String _baseUrl =
      'https://dev.inviteflare.com/api/'; // 🔗 Define here

  final Dio _dio;

  final List<Interceptor>? interceptors;

  DioClient(
    Dio dio, {
    this.interceptors,
  }) : _dio = dio {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl, // Use static base URL
      connectTimeout: _defaultConnectTimeout,
      receiveTimeout: _defaultReceiveTimeout,
      contentType: setContentType(),
      headers: {
        'Content-Type': setContentType(),
      },
    );

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor.LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
        request: false,
        requestBody: true,
      ));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool skipAuth = false,
  }) async {
    try {
      if (!skipAuth) {
        var token = await TokenService().getAccessToken();
        debugPrint("Bearer: $token");

        if (token != null) {
          options ??= Options();
          options.headers = {
            ...?options.headers,
            "Authorization": "Bearer $token",
          };
        }
      }

      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException {
      throw FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool skipAuth = false,
  }) async {
    try {
      if (!skipAuth) {
        var token = await TokenService().getAccessToken();
        debugPrint("Authorization token: $token");

        if (token != null) {
          options ??= Options();
          options.headers = {
            ...?options.headers,
            "Authorization": "Bearer $token",
          };
        }
      }

      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on FormatException {
      throw FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool skipAuth = false,
  }) async {
    try {
      if (!skipAuth) {
        var token = await TokenService().getAccessToken();
        debugPrint("Authorization token: $token");

        if (token != null) {
          options ??= Options();
          options.headers = {
            ...?options.headers,
            "Authorization": "Bearer $token",
          };
        }
      }
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on FormatException {
      throw FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> patch(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool skipAuth = false,
      }) async {
    try {
      if (!skipAuth) {
        var token = await TokenService().getAccessToken();
        debugPrint("Authorization token: $token");

        if (token != null) {
          options ??= Options();
          options.headers = {
            ...?options.headers,
            "Authorization": "Bearer $token",
          };
        }
      }

      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on FormatException {
      throw FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }




}
