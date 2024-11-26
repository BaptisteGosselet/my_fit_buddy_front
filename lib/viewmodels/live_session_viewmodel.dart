import 'package:my_fit_buddy/data/models/session_content.dart';
import 'package:my_fit_buddy/data/models/session_content_exo_key.dart';
import 'package:my_fit_buddy/data/services/session_content_service.dart';
import 'package:my_fit_buddy/data/services/session_service.dart';

class LiveSessionViewmodel {
  final String sessionId;

  final sessionContentService = SessionContentService();

  LiveSessionViewmodel(this.sessionId) {
    print('LiveSessionViewmodel created with sessionId: $sessionId');
  }

  Future<bool> init() async {
    List<SessionContentExoKey> t =
        await sessionContentService.getSessionContents(sessionId);
    print("content : $t");
    return t.isNotEmpty;
  }
}
