class Utils {
  Utils._singleton();
  static final Utils instance = Utils._singleton();

  bool isValidEmail(String s) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(s);
  }

  String usernameForbiddenCharacters(String s) {
    final validCharacters = RegExp(r'^[a-zA-Z0-9._-]+$');
    String forbiddenCharacters = '';

    for (int i = 0; i < s.length; i++) {
      if (!validCharacters.hasMatch(s[i])) {
        forbiddenCharacters += '${s[i]}, ';
      }
    }

    if (forbiddenCharacters.isNotEmpty) {
      forbiddenCharacters =
          forbiddenCharacters.substring(0, forbiddenCharacters.length - 2);
    }

    return forbiddenCharacters;
  }

  int convertStringTimeToSeconds(final String mmss) {
/** Exemple mmss = "123:00" ou "0:123" */
    final parts = mmss.split(':');
    if (parts.length != 2) {
      throw const FormatException('Le format attendu est mm:ss');
    }

    final minutes = int.tryParse(parts[0]) ?? 0;
    final seconds = int.tryParse(parts[1]) ?? 0;

    return (minutes * 60) + seconds;
  }
}
