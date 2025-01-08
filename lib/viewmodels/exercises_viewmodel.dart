import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/services/exercises_service.dart';

class ExercisesViewmodel {
  final ExercisesService exercisesService = ExercisesService();

  List<Exercise> exercises = [];
  bool isLoading = false;

  Future<List<Exercise>> updateExercises(
      String key, String muscleGroup, int pageIndex) async {
    if (isLoading) {
      return [];
    }
    isLoading = true;

    try {
      List<Exercise> newExercises = await exercisesService.getExercises(
        key,
        muscleGroup,
        pageIndex,
      );

      exercises.addAll(newExercises);

      return newExercises;
    } catch (error) {
      return [];
    } finally {
      isLoading = false;
    }
  }
}
