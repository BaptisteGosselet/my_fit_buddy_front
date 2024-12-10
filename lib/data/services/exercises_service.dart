import 'package:dio/dio.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';

class ExercisesService {
  static const String exercisesUrl = "/exercises";

  String generateGetEndpoint(
      String key, String muscleGroup, int pageIndex, int pageSize) {
    List<String> params = [];

    if (key.isNotEmpty) params.add('key=$key');
    if (muscleGroup.isNotEmpty) params.add('muscleGroup=$muscleGroup');

    params.add('page=$pageIndex');
    params.add('size=$pageSize');

    return '$exercisesUrl?${params.join('&')}';
  }

  Future<List<Exercise>> getExercises(
      String key, String muscleGroup, int pageIndex) async {
    print("S getExercises");
    const int pageSize = 10;
    String endpoint =
        generateGetEndpoint(key, muscleGroup, pageIndex, pageSize);
    print(endpoint);

    try {
      final response =
          await APIService.instance.request(endpoint, DioMethod.get);
      print(response);

      final content = (response.data['content'] as List)
          .map((item) => Exercise.fromJson(item))
          .toList();
      print(content);
      return content;
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      return [];
    }
  }

  Future<Exercise> getExerciseById(int exerciseId) async {
    print("S getExerciseById: $exerciseId");

    String endpoint = "$exercisesUrl/$exerciseId";
    print("Endpoint: $endpoint");

    try {
      final response =
          await APIService.instance.request(endpoint, DioMethod.get);
      print("Response: ${response.data}");

      return Exercise.fromJson(response.data);
    } on DioException catch (e) {
      print('Request failed: ${e.response?.statusCode}, ${e.message}');
      rethrow;
    }
  }
}
