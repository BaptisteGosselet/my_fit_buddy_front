import 'package:my_fit_buddy/data/models/session.dart';
import 'package:my_fit_buddy/data/services/session_service.dart';

class SessionViewmodel {
  SessionService sessionService = SessionService();

  Future<Session> getSessionByID(String id) async {
    print("getSessionByID");
    return await sessionService.getUserSessionByID(id);
  }
}
