import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_fit_buddy/core/http/refresh_token_action.dart';
import 'package:my_fit_buddy/managers/token_manager.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor(Dio dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Ignorer les requêtes non authentifiées
    if (options.headers.containsKey('no-auth')) {
      return handler.next(options);
    }

    // Vérifie si le jeton d'accès est valide
    if (!await TokenManager.instance.isAccessTokenValid()) {
      // Éviter les boucles infinies lors du rafraîchissement
      if (options.extra['refresh_attempt'] == true) {
        return handler.reject(DioException(
          requestOptions: options,
          error: 'Token is invalid after refresh attempt',
        ));
      }
    }

    // Rafraîchir le token
    if (options.headers.containsKey('skip-refresh')) {
    } else {
      final success = await RefreshTokenAction.instance.refreshToken();
      if (!success) {
        return handler.reject(DioException(
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: 401,
            statusMessage: 'Unauthorized: Token is invalid',
          ),
          error: 'Token is invalid',
        ));
      }
    }

    // Ajouter le jeton d'accès dans les en-têtes
    final String? token = await TokenManager.instance.getAccessToken();
    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    } else {}

    return handler.next(options);
  }
}
