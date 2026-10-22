import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/api_endpoints.dart';
import '../storage/local_storage.dart';

class ApiClient {
  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            headers: {'Accept': 'application/json'},
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = LocalStorage.instance.token;
          if (token != null) options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  final Dio dio;
}
