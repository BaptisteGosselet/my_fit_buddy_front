import 'package:dio/dio.dart';
import 'package:my_fit_buddy/data/models/session_content_create_form.dart';
import 'package:my_fit_buddy/data/models/session_content_exercise.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';

class SessionContentService {
  static const String sessionContentUrl = "/sessionContent";

  Future<List<SessionContentExercise>> getSessionContents(String id) async {
    print("id : $id");
    try {
      final response = await APIService.instance.request(
        '$sessionContentUrl/$id',
        DioMethod.get,
      );
      if (response.statusCode == 200) {
        if (response.data is List) {
          print("response.data : ${response.data}");
          return (response.data as List)
              .map((sessionContentJson) =>
                  SessionContentExercise.fromJson(sessionContentJson))
              .toList();
        } else {
          print('Les données ne sont pas sous forme de liste');
          return [];
        }
      } else {
        print(
            'Erreur lors de la récupération des sessions contents : ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return [];
    }
  }

  Future<bool> createNewSessionContent(SessionContentCreateForm form) async {
    try {
      final response = await APIService.instance
          .request(sessionContentUrl, DioMethod.post, param: form.toJson());
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          return true;
        } else {
          print(
              'Erreur lors de la création des sessions content : ${response.statusCode}');
          return Future.error(
              'Erreur lors de la création de la session content : ${response.statusCode}');
        }
      } else {
        print(
            'Erreur lors de la création des sessions content : ${response.statusCode}');
        return Future.error(
            'Erreur lors de la création de la session content : ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }

  Future<bool> deleteSessionContent(int id) async {
    try {
      final response = await APIService.instance
          .request("$sessionContentUrl/$id", DioMethod.delete);
      if (response.statusCode == 200) {
        print('return true delete sucess');
        return true;
      } else {
        print(
            'Erreur lors de la suppression du sessions content : ${response.statusCode}');
        return Future.error(
            'Erreur lors de la suppression de la session content : ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return Future.error(
          'Request failed: ${e.response?.statusCode}, ${e.message}');
    }
  }
}
