import 'package:dio/dio.dart';
import 'package:my_fit_buddy/core/http/http.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';

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
    const int pageSize = 10;
    String endpoint =
        generateGetEndpoint(key, muscleGroup, pageIndex, pageSize);

    try {
      final response = await Http.instance.request(endpoint, DioMethod.get);

      final content = (response.data['content'] as List)
          .map((item) => Exercise.fromJson(item))
          .toList();
      return content;
    } on DioException {
      return [];
    }
  }

  Future<Exercise> getExerciseById(int exerciseId) async {
    String endpoint = "$exercisesUrl/$exerciseId";

    try {
      final response = await Http.instance.request(endpoint, DioMethod.get);

      return Exercise.fromJson(response.data);
    } on DioException {
      rethrow;
    }
  }
}
