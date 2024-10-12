import 'package:flutter/foundation.dart' show kIsWeb;

//Local API config
var configBaseAPI =
    (!kIsWeb) ? "http://10.0.2.2:8080" : "http://localhost:8080";
