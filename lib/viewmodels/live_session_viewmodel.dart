import 'package:my_fit_buddy/data/models/session_content_exercise.dart';
import 'package:my_fit_buddy/data/services/session_content_service.dart';

class LiveSessionViewmodel {
  final String sessionId;
  int pos = 0;

  final sessionContentService = SessionContentService();
  List<SessionContentExercise> sessionContentExerciseList = [];

  LiveSessionViewmodel(this.sessionId) {
    print('LiveSessionViewmodel created with sessionId: $sessionId');
  }

  Future<bool> init() async {
    pos = 0;
    sessionContentExerciseList =
        await sessionContentService.getSessionContents(sessionId);
    return sessionContentExerciseList.isNotEmpty;
  }

  SessionContentExercise getCurrentSessionContentExercise() {
    return sessionContentExerciseList[pos];
  }

  Future<void> saveRecord(
      SessionContentExercise sessionContentExercise, int reps, int kg) async {
    print('$sessionContentExercise $reps, $kg');
  }

  void incrementPos() {
    pos++;
  }
}
