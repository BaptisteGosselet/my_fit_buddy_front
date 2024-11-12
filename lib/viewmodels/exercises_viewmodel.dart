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

    print("VM updateExercises - Start");
    print(
        "Paramètres: key=$key, muscleGroup=$muscleGroup, pageIndex=$pageIndex");
    isLoading = true;

    try {
      List<Exercise> newExercises = await exercisesService.getExercises(
        key,
        muscleGroup,
        pageIndex,
      );

      exercises.addAll(newExercises);

      print("Total exercises loaded: ${exercises.length}");
      return newExercises;
    } catch (error) {
      print("Erreur lors de l'appel à l'API: $error");
      return [];
    } finally {
      isLoading = false;
      print("VM updateExercises - End");
    }
  }
}
