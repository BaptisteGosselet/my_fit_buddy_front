import 'package:my_fit_buddy/data/models/session_content_models/session_content_update_form.dart';
import 'package:my_fit_buddy/data/models/session_models/session.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_create_form.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_exercise.dart';
import 'package:my_fit_buddy/data/models/session_models/session_create_form.dart';
import 'package:my_fit_buddy/data/models/session_models/session_update_form.dart';
import 'package:my_fit_buddy/data/services/session_service.dart';
import 'package:my_fit_buddy/data/services/session_content_service.dart';

class SessionViewmodel {
  SessionService sessionService = SessionService();
  SessionContentService sessionContentService = SessionContentService();

  Future<Session> getSessionByID(String id) async {
    return await sessionService.getUserSessionByID(id);
  }

  Future<List<SessionContentExercise>> getSessionContents(String id) async {
    return await sessionContentService.getSessionContents(id);
  }

  Future<Session> createNewSession(String newSessionName) async {
    return await sessionService
        .createNewSession(SessionCreateForm(name: newSessionName));
  }

  Future<bool> createNewSessionContent(final int idSession,
      final int idExercise, final int nbSet, final int restSeconds) async {
    return await sessionContentService.createNewSessionContent(
        SessionContentCreateForm(
            sessionId: idSession,
            exerciseId: idExercise,
            numberOfSet: nbSet,
            restTimeInSecond: restSeconds));
  }

  Future<bool> deleteSessionContent(final int id) async {
    return await sessionContentService.deleteSessionContent(id);
  }

  Future<Session> renameSession(int id, String newName) async {
    return await sessionService
        .renameSession(SessionUpdateForm(sessionId: id, name: newName));
  }

  Future<bool> deleteSession(int id) async {
    return sessionService.deleteSession(id);
  }

  void setNewContentOrder(List<SessionContentExercise> sessionContents) async {
    List<SessionContentUpdateForm> toUpdateList = [];
    for (int i = 0; i < sessionContents.length; i++) {
      toUpdateList.add(SessionContentUpdateForm(
          id: sessionContents[i].id,
          index: i,
          numberOfSet: sessionContents[i].numberOfSets,
          restTimeInSecond: sessionContents[i].restTimeInSecond));
    }
    sessionContentService.setNewContentOrder(toUpdateList);
  }

  Future<bool> updateSessionContent(
      SessionContentUpdateForm sessionContentUpdated) {
    return sessionContentService.updateSessionContent(sessionContentUpdated);
  }
}
