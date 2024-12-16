import 'package:my_fit_buddy/data/models/session_models/session.dart';
import 'package:my_fit_buddy/data/services/session_service.dart';

class SessionsListViewmodel {
  SessionService sessionService = SessionService();

  Future<List<Session>> getSessionsList() async {
    print("getSessionsList");
    List<Session> response = await sessionService.getUserSessions();
    print(response);
    return response;
  }
}
