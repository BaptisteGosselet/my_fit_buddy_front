import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/data/services/exercises_service.dart';
import 'package:my_fit_buddy/data/services/fit_record_service.dart';

class ExerciseSetsViewmodel {
  ExercisesService exercisesService = ExercisesService();
  FitRecordService fitRecordService = FitRecordService();

  Future<Exercise> getExerciseById(int exerciseId) {
    return exercisesService.getExerciseById(exerciseId);
  }

  Future<List<FitSet>> getPreviousSetsOfExercise(int exerciseId) async {
    return await fitRecordService.getExercisePreviousSets(exerciseId);
  }
}
