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
}
