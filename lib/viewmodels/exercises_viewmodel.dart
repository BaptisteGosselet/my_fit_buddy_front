import 'package:my_fit_buddy/data/models/exercise.dart';
import 'package:my_fit_buddy/data/services/exercises_service.dart';

class ExercisesViewmodel {
  final ExercisesService exercisesService = ExercisesService();

  List<Exercise> exercises = [];

  Future<void> updateExercises(
      String key, String muscleGroup, int pageIndex) async {
    print("VM updateExercises");
    print("$key $muscleGroup $pageIndex");
    exercises =
        await exercisesService.getExercises(key, muscleGroup, pageIndex);
    print(exercises);
  }
}
