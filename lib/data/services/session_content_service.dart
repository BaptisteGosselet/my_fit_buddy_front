import 'package:dio/dio.dart';
import 'package:my_fit_buddy/data/models/session_content_exo_key.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';

class SessionContentService {
  static const String sessionContentUrl = "/sessionContent";

  Future<List<SessionContentExoKey>> getSessionContents(String id) async {
    try {
      final response = await APIService.instance.request(
        '$sessionContentUrl/$id',
        DioMethod.get,
      );
      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List)
              .map((sessionContentJson) => SessionContentExoKey.fromJson(sessionContentJson))
              .toList();
        } else {
          print('Les données ne sont pas sous forme de liste');
          return [];
        }
      } else {
        print('Erreur lors de la récupération des sessions : ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return [];
    }
  }
}