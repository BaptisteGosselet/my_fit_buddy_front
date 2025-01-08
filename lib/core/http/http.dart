import 'package:dio/dio.dart';
import 'package:my_fit_buddy/core/config.dart';
import 'package:my_fit_buddy/core/http/token_interceptor.dart';

enum DioMethod { post, get, put, delete }

class Http {
  Http._singleton();
  static final Http instance = Http._singleton();

  static final BaseOptions options = BaseOptions(
    baseUrl: configBaseAPI,
    contentType: 'application/json',
    connectTimeout: const Duration(milliseconds: 10000),
    receiveTimeout: const Duration(milliseconds: 6000),
  );

  final Dio http = Dio(options)
    ..interceptors.add(TokenInterceptor(Dio(options)))
    ..interceptors.add(LogInterceptor());

  Future<Response> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    List<Map<String, dynamic>>? params,
    FormData? formData,
    bool authenticated = true,
    bool skipRefreshing = false,
  }) async {
    if (authenticated) {
      options.headers.remove('no-auth');
    } else {
      options.headers['no-auth'] = true;
    }

    if (skipRefreshing) {
      options.headers['skip-refresh'] = true;
    } else {
      options.headers.remove('skip-refresh');
    }

    try {
      switch (method) {
        case DioMethod.post:
          return await http.post(
            endpoint,
            data: param ?? formData ?? params,
          );
        case DioMethod.get:
          return await http.get(
            endpoint,
            queryParameters: param,
          );
        case DioMethod.put:
          return await http.put(
            endpoint,
            data: param ?? formData ?? params,
          );
        case DioMethod.delete:
          return await http.delete(
            endpoint,
            data: param ?? formData ?? params,
          );
        default:
          return await http.post(
            endpoint,
            data: param ?? formData ?? params,
          );
      }
    } on DioException catch (e) {
      return e.response ??
          Response(
            requestOptions: RequestOptions(path: endpoint),
            statusCode: 500,
            statusMessage: 'Request failed: ${e.message}',
          );
    }
  }
}
