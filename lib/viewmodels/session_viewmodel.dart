import 'package:my_fit_buddy/data/models/session.dart';
import 'package:my_fit_buddy/data/models/session_content_exo_key.dart';
import 'package:my_fit_buddy/data/services/session_service.dart';
import 'package:my_fit_buddy/data/services/session_content_service.dart';

class SessionViewmodel {
  SessionService sessionService = SessionService();
  SessionContentService sessionContentService = SessionContentService();

  Future<Session> getSessionByID(String id) async {
    print("getSessionByID : $id");
    return await sessionService.getUserSessionByID(id);
  }

  Future<List<SessionContentExoKey>> getSessionContents(String id) async {
    return await sessionContentService.getSessionContents(id);
  }

  Future<Session> createNewSession(String newSessionName) async {
    return await sessionService.createNewSession(newSessionName);
  }
}
