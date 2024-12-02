import 'package:dio/dio.dart';
import 'package:my_fit_buddy/data/models/session.dart';
import 'package:my_fit_buddy/data/models/session_create_form.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';

class SessionService {
  static const String sessionsUrl = "/sessions";

  Future<List<Session>> getUserSessions() async {
    try {
      final response = await APIService.instance.request(
        "$sessionsUrl/user",
        DioMethod.get,
      );
      print(response);
      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List)
              .map((sessionJson) => Session.fromJson(sessionJson))
              .toList();
        } else {
          print('Les données ne sont pas sous forme de liste');
          return [];
        }
      } else {
        print(
            'Erreur lors de la récupération des sessions : ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return [];
    }
  }

  Future<Session> getUserSessionByID(String id) async {
    try {
      final response =
          await APIService.instance.request("$sessionsUrl/$id", DioMethod.get);
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          Session session = Session.fromJson(response.data);
          return session;
        } else {
          print('Aucune donnée');
          return Future.error('Aucune donnée');
        }
      } else {
        print(
            'Erreur lors de la récupération des sessions : ${response.statusCode}');
        return Future.error(
            'Erreur lors de la récupération de la session $id : ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }

  Future<Session> createNewSession(SessionCreateForm form) async {
    try {
      print("SessionCreateForm ${form.name}");

      final response = await APIService.instance
          .request(sessionsUrl, DioMethod.post, param: form.toJson());
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          return Session.fromJson(response.data);
        } else {
          print('Aucune donnée');
          return Future.error('Aucune donnée');
        }
      } else {
        print(
            'Erreur lors de la création des sessions : ${response.statusCode}');
        return Future.error(
            'Erreur lors de la création de la session : ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }
}
