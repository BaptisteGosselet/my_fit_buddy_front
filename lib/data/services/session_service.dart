import 'package:dio/dio.dart';
import 'package:my_fit_buddy/core/http/http.dart';
import 'package:my_fit_buddy/data/models/session_models/session.dart';
import 'package:my_fit_buddy/data/models/session_models/session_create_form.dart';
import 'package:my_fit_buddy/data/models/session_models/session_update_form.dart';

class SessionService {
  static const String sessionsUrl = "/sessions";

  Future<List<Session>> getUserSessions() async {
    try {
      final response = await Http.instance.request(
        "$sessionsUrl/user",
        DioMethod.get,
      );
      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List)
              .map((sessionJson) => Session.fromJson(sessionJson))
              .toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } on DioException {
      return [];
    }
  }

  Future<Session> getUserSessionByID(String id) async {
    try {
      final response =
          await Http.instance.request("$sessionsUrl/$id", DioMethod.get);
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          Session session = Session.fromJson(response.data);
          return session;
        } else {
          return Future.error('Aucune donnée');
        }
      } else {
        return Future.error(
            'Erreur lors de la récupération de la session $id : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }

  Future<Session> createNewSession(SessionCreateForm form) async {
    try {
      final response = await Http.instance
          .request(sessionsUrl, DioMethod.post, param: form.toJson());
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          return Session.fromJson(response.data);
        } else {
          return Future.error('Aucune donnée');
        }
      } else {
        return Future.error(
            'Erreur lors de la création de la session : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }

  Future<Session> renameSession(SessionUpdateForm sessionUpdateForm) async {
    try {
      final response = await Http.instance.request(
          '$sessionsUrl/${sessionUpdateForm.sessionId}', DioMethod.put,
          param: sessionUpdateForm.toJson());
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          return Session.fromJson(response.data);
        } else {
          return Future.error('Aucune donnée');
        }
      } else {
        return Future.error(
            'Erreur lors du rename de la session : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }

  Future<bool> deleteSession(int id) async {
    try {
      final response = await Http.instance.request(
        '$sessionsUrl/$id',
        DioMethod.delete,
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return Future.error(
            'Erreur lors du rename de la session : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }
}
