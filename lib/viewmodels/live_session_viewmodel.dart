import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_exercise.dart';
import 'package:my_fit_buddy/data/services/fit_record_service.dart';
import 'package:my_fit_buddy/data/services/session_content_service.dart';

class LiveSessionViewmodel {
  final String sessionId;
  int idxExercise = 0;
  int idxSet = 0;

  late FitRecord currentRecord;

  final sessionContentService = SessionContentService();
  final fitRecordService = FitRecordService();
  List<SessionContentExercise> sessionContentExerciseList = [];

  LiveSessionViewmodel(this.sessionId) {
    print('LiveSessionViewmodel created with sessionId: $sessionId');
  }

  Future<bool> init() async {
    idxExercise = 0;
    idxSet = 0;
    sessionContentExerciseList =
        await sessionContentService.getSessionContents(sessionId);

    currentRecord = await fitRecordService.createRecord();

    return sessionContentExerciseList.isNotEmpty;
  }

  SessionContentExercise getCurrentSessionContentExercise() {
    print('GET EXERCICE INDEX $idxExercise');
    return sessionContentExerciseList[idxExercise];
  }

  int getCurrentSetIndex() {
    return idxSet;
  }

  Future<void> saveRecord(
      SessionContentExercise sessionContentExercise, int reps, int kg) async {
    await fitRecordService.createFitSet(currentRecord.id,
        sessionContentExercise.exercise.id, getCurrentSetIndex(), reps, kg);
  }

  bool next() {
    SessionContentExercise current = getCurrentSessionContentExercise();
    if (idxSet < current.numberOfSet - 1) {
      idxSet++;
      print('IdxSet incremented to $idxSet');
      return true;
    }

    idxSet = 0;
    print('IdxSet reset to 0');
    print(
        'IdxExercise: $idxExercise / List Length: ${sessionContentExerciseList.length - 1}');

    if (idxExercise < sessionContentExerciseList.length - 1) {
      idxExercise++;
      print('IdxExercise incremented to $idxExercise');
      return true;
    }

    print('Reached end of sessionContentExerciseList');
    return false;
  }
}
