import 'package:my_fit_buddy/data/models/session_content_models/session_content_exercise.dart';
import 'package:my_fit_buddy/data/models/session_models/session.dart';
import 'package:my_fit_buddy/data/services/session_content_service.dart';
import 'package:my_fit_buddy/data/services/session_service.dart';

class SessionsListViewmodel {
  SessionService sessionService = SessionService();
  SessionContentService sessionContentService = SessionContentService();

  Future<List<Session>> getSessionsList() async {
    List<Session> response = await sessionService.getUserSessions();
    return response;
  }

  Future<int> getSessionExercicesNumber(final int idSession) async {
    final List<SessionContentExercise> sessions =
        await sessionContentService.getSessionContents("$idSession");
    return sessions.length;
  }
}
