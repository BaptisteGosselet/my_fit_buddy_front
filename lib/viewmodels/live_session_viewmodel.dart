import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_exercise.dart';
import 'package:my_fit_buddy/data/services/fit_record_service.dart';
import 'package:my_fit_buddy/data/services/session_content_service.dart';

class LiveSessionViewModel {
  // Fields
  final String sessionId;
  final sessionContentService = SessionContentService();
  final fitRecordService = FitRecordService();

  int idxExercise = 0;
  int idxSet = 0;

  late FitRecord currentRecord;
  late List<SessionContentExercise> sessionContentExerciseList;
  late List<List<int>> setIdsArray;

  // Constructor
  LiveSessionViewModel(this.sessionId) {
    print('LiveSessionViewModel created with sessionId: $sessionId');
  }

  // Initialization
  Future<bool> init() async {
    idxExercise = 0;
    idxSet = 0;

    sessionContentExerciseList =
        await sessionContentService.getSessionContents(sessionId);
    currentRecord = await fitRecordService.createRecord(sessionId);

    if (sessionContentExerciseList.isEmpty) {
      return false;
    }

    // Initialize setIdsArray without list comprehension
    setIdsArray = [];
    for (var exercise in sessionContentExerciseList) {
      List<int> innerList = [];
      for (int i = 0; i < exercise.getNumberOfSets(); i++) {
        innerList.add(-1);
      }
      setIdsArray.add(innerList);
    }

    return true;
  }

  // Getters for current indices and exercises
  SessionContentExercise getCurrentSessionContentExercise() {
    print('Current exercise index: $idxExercise');
    return sessionContentExerciseList[idxExercise];
  }

  int getCurrentSetIndex() => idxSet;
  int getCurrentExerciseIndex() => idxExercise;

  // Setters for indices
  void setFitSetIndex(int n) => idxSet = n;
  void setExerciseIndex(int n) => idxExercise = n;

  Future<void> saveRecord(
      SessionContentExercise sessionContentExercise, int reps, int kg) async {
    print(
        'Saving record for set ${idxSet + 1} of exercise ${sessionContentExercise.exercise.id}');

    try {
      int idSetToUpdate = setIdsArray[idxExercise][idxSet];
      FitSet savedSet;

      if (idSetToUpdate == -1) {
        // Créer un nouveau set
        savedSet = await fitRecordService.createFitSet(
          currentRecord.id,
          sessionContentExercise.exercise.id,
          idxSet + 1,
          reps,
          kg,
        );
      } else {
        // Mettre à jour un existant
        savedSet = await fitRecordService.updateFitSet(
          idSetToUpdate,
          idxSet + 1,
          reps,
          kg,
        );
      }

      // Met à jour l'ID dans la matrice
      setIdsArray[idxExercise][idxSet] = savedSet.id;

      print('Record saved with ID: ${savedSet.id}');
    } catch (e) {
      print('Error saving record: $e');
    }
  }

  // Move to the next set or exercise
  bool next() {
    final current = getCurrentSessionContentExercise();

    if (idxSet < current.getNumberOfSets() - 1) {
      idxSet++;
      print('Moved to next set: $idxSet');
      return true;
    }

    idxSet = 0;
    print('Reset set index to 0');

    if (idxExercise < sessionContentExerciseList.length - 1) {
      idxExercise++;
      print('Moved to next exercise: $idxExercise');
      return true;
    }

    print('End of session reached');
    return false;
  }

  // Get list of exercises
  List<Exercise> getExercisesList() {
    return sessionContentExerciseList
        .map((sessionContent) => sessionContent.getExercise())
        .toList();
  }
}
