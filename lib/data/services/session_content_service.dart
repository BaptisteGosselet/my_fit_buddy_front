import 'package:dio/dio.dart';
import 'package:my_fit_buddy/core/http/http.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_create_form.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_exercise.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_update_form.dart';

class SessionContentService {
  static const String sessionContentUrl = "/sessionContent";

  Future<List<SessionContentExercise>> getSessionContents(String id) async {
    try {
      final response = await Http.instance.request(
        '$sessionContentUrl/$id',
        DioMethod.get,
      );
      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List)
              .map((sessionContentJson) =>
                  SessionContentExercise.fromJson(sessionContentJson))
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

  Future<bool> createNewSessionContent(SessionContentCreateForm form) async {
    try {
      final response = await Http.instance
          .request(sessionContentUrl, DioMethod.post, param: form.toJson());
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          return true;
        } else {
          return Future.error(
              'Erreur lors de la création de la session content : ${response.statusCode}');
        }
      } else {
        return Future.error(
            'Erreur lors de la création de la session content : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }

  Future<bool> deleteSessionContent(int id) async {
    try {
      final response = await Http.instance
          .request("$sessionContentUrl/$id", DioMethod.delete);
      if (response.statusCode == 200) {
        return true;
      } else {
        return Future.error(
            'Erreur lors de la suppression de la session content : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }

  void setNewContentOrder(List<SessionContentUpdateForm> toUpdateList) async {
    try {
      final List<Map<String, dynamic>> jsonList =
          toUpdateList.map((item) => item.toJson()).toList();

      final response = await Http.instance
          .request("$sessionContentUrl/list", DioMethod.put, params: jsonList);
      if (response.statusCode == 200) {
      } else {
        return Future.error(
            'Erreur lors de l\'update de sessions content : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }

  Future<bool> updateSessionContent(
      SessionContentUpdateForm sessionContentUpdated) async {
    try {
      final response = await Http.instance.request(
          "$sessionContentUrl/${sessionContentUpdated.id}", DioMethod.put,
          param: sessionContentUpdated.toJson());
      if (response.statusCode == 200) {
        return true;
      } else {
        return Future.error(
            'Erreur lors de l\'update de sessions content : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }
}
