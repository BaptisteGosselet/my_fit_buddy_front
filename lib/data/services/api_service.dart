import 'dart:io';

import 'package:my_fit_buddy/core/config.dart';
import 'package:dio/dio.dart';
import 'package:my_fit_buddy/data/models/auth_models/token.dart';
import 'package:my_fit_buddy/data/services/auth_service/token_storage_service.dart';

enum DioMethod { post, get, put, delete }

class APIService {
  APIService._singleton();
  static final APIService instance = APIService._singleton();

  final dio = Dio(
    BaseOptions(
      baseUrl: configBaseAPI,
      contentType: 'application/json',
    ),
  );

  Future<Response> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    FormData? formData,
  }) async {
    final currentToken = await TokenStorageService.instance.getToken();
    if (currentToken != null) {
      await retrieveRefreshToken();
      final newToken = await TokenStorageService.instance.getToken();

      if (newToken?.accessToken != null) {
        dio.options.headers[HttpHeaders.authorizationHeader] =
            'Bearer ${newToken!.accessToken}';
      }
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

  Future<void> retrieveRefreshToken() async {
    String endpoint = "/auth/refresh-token";

    final tokenStorageService = TokenStorageService.instance;
    final token = await tokenStorageService.getToken();

    if (token?.accessToken != null) {
      dio.options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${token!.accessToken}';
    }

    final Response response = await dio.post(endpoint);

    try {
      if (response.statusCode == 200) {
        TokenStorageService.instance.saveToken(Token.fromJson(response.data));
      } else {
        print('Erreur lors de la connexion : ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return;
    }
  }

  Future<String> test() async {
    try {
      final response =
          await APIService.instance.request("/test", DioMethod.get);
      return response.data.toString();
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return 'Erreur lors de la requête';
    }
  }
}
