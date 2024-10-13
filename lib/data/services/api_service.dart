import 'dart:io';

import 'package:my_fit_buddy/core/config.dart';
import 'package:dio/dio.dart';
import 'package:my_fit_buddy/data/services/auth_service/token_storage_service.dart';

enum DioMethod { post, get, put, delete }

class APIService {
  APIService._singleton();
  static final APIService instance = APIService._singleton();

  String get baseUrl {
    return configBaseAPI;
  }

  Future<Response> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    String? contentType,
    FormData? formData,
  }) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: contentType ?? Headers.formUrlEncodedContentType,
      ),
    );

    final tokenStorageService = TokenStorageService.instance;
    final token = await tokenStorageService.getToken();

    if (token?.accessToken != null) {
      dio.options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${token!.accessToken}';
    }

    try {
      switch (method) {
        case DioMethod.post:
          return dio.post(
            endpoint,
            data: param ?? formData,
          );
        case DioMethod.get:
          return dio.get(
            endpoint,
            queryParameters: param,
          );
        case DioMethod.put:
          return dio.put(
            endpoint,
            data: param ?? formData,
          );
        case DioMethod.delete:
          return dio.delete(
            endpoint,
            data: param ?? formData,
          );
        default:
          return dio.post(
            endpoint,
            data: param ?? formData,
          );
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      rethrow;
    }
  }

  Future<String> test() async {
    try {
      final response = await APIService.instance
          .request("/test", DioMethod.get, contentType: 'application/json');
      return response.data.toString();
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return 'Erreur lors de la requête';
    }
  }
}
