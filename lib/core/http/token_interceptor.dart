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
    print('Intercepting request: ${options.path}');
    print(options.headers);

    // Ignorer les requêtes non authentifiées
    if (options.headers.containsKey('no-auth')) {
      print('No-auth header found, skipping token validation');
      return handler.next(options);
    }

    // Vérifie si le jeton d'accès est valide
    if (!await TokenManager.instance.isAccessTokenValid()) {
      print('Access token is invalid, attempting to refresh...');

      // Éviter les boucles infinies lors du rafraîchissement
      if (options.extra['refresh_attempt'] == true) {
        print('Token refresh already attempted, rejecting request');
        return handler.reject(DioException(
          requestOptions: options,
          error: 'Token is invalid after refresh attempt',
        ));
      }
    }

    print(
        "ici : l'erreur se trouve dans le rafraichissement du token, success est false");

    // Rafraîchir le token
    if (options.headers.containsKey('skip-refresh')) {
      print('Skip-refresh header found, skipping token refresh');
    } else {
      final success = await RefreshTokenAction.instance.refreshToken();
      if (!success) {
        print('Token refresh failed, rejecting request');
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
    print('Access token refreshed, proceeding...');
    final String? token = await TokenManager.instance.getAccessToken();
    if (token != null) {
      print('Access token found: $token');
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    } else {
      print('Access token not found');
    }

    print('Request authorized, proceeding...');
    return handler.next(options);
  }
}
