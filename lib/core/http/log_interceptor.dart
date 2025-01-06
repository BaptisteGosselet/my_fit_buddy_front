import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class LogInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final request = response.requestOptions;
    final logger = Logger('Http');
    logger.info(
      '${response.statusCode} - ${request.method} ${request.uri}',
    );

    return handler.next(response);
  }
}
