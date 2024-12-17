import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Utils {
  Utils._singleton();
  static final Utils instance = Utils._singleton();

  bool isValidEmail(String s) {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$")
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
    if (mmss.isEmpty) {
      return 0;
    }
    final parts = mmss.split(':');
    if (parts.length != 2) {
      throw const FormatException('Le format attendu est mm:ss');
    }

    final minutes = int.tryParse(parts[0]) ?? 0;
    final seconds = int.tryParse(parts[1]) ?? 0;

    return (minutes * 60) + seconds;
  }

  String convertSecondsToStringTime(final int s) {
    final int min = s ~/ 60;
    final int sec = s % 60;
    return "$min:${sec.toString().padLeft(2, '0')}";
  }

  String getTranslatedExerciseLabel(context, exercise) {
    return AppLocalizations.of(context)!.languageCode == 'fr'
        ? exercise.labelFr
        : exercise.labelEn;
  }

  String getRecordsDateString_1(context, DateTime date) {
    final String monthName = getMonth(context, date.month);
    final String shortYear = (date.year % 100).toString().padLeft(2, '0');
    return "${date.day} $monthName $shortYear";
  }

  String getRecordsDateString_2(context, DateTime date) {
    String weekdayName = getWeekday(context, date.weekday);
    String monthName = getMonth(context, date.month);
    return "$weekdayName ${date.day} $monthName ${date.year}";
  }

  String getWeekday(context, int n) {
    switch (n) {
      case 1:
        return AppLocalizations.of(context)!.monday_abr;
      case 2:
        return AppLocalizations.of(context)!.tuesday_abr;
      case 3:
        return AppLocalizations.of(context)!.wednesday_abr;
      case 4:
        return AppLocalizations.of(context)!.thursday_abr;
      case 5:
        return AppLocalizations.of(context)!.friday_abr;
      case 6:
        return AppLocalizations.of(context)!.saturday_abr;
      case 7:
        return AppLocalizations.of(context)!.sunday_abr;
    }
    return "";
  }

  String getMonth(context, int n) {
    switch (n) {
      case 1:
        return AppLocalizations.of(context)!.january_abr;
      case 2:
        return AppLocalizations.of(context)!.february_abr;
      case 3:
        return AppLocalizations.of(context)!.march_abr;
      case 4:
        return AppLocalizations.of(context)!.april_abr;
      case 5:
        return AppLocalizations.of(context)!.may_abr;
      case 6:
        return AppLocalizations.of(context)!.june_abr;
      case 7:
        return AppLocalizations.of(context)!.july_abr;
      case 8:
        return AppLocalizations.of(context)!.august_abr;
      case 9:
        return AppLocalizations.of(context)!.september_abr;
      case 10:
        return AppLocalizations.of(context)!.october_abr;
      case 11:
        return AppLocalizations.of(context)!.november_abr;
      case 12:
        return AppLocalizations.of(context)!.december_abr;
    }
    return "";
  }

  String getMonthFull(context, int n) {
    switch (n) {
      case 1:
        return AppLocalizations.of(context)!.january;
      case 2:
        return AppLocalizations.of(context)!.february;
      case 3:
        return AppLocalizations.of(context)!.march;
      case 4:
        return AppLocalizations.of(context)!.april;
      case 5:
        return AppLocalizations.of(context)!.may;
      case 6:
        return AppLocalizations.of(context)!.june;
      case 7:
        return AppLocalizations.of(context)!.july;
      case 8:
        return AppLocalizations.of(context)!.august;
      case 9:
        return AppLocalizations.of(context)!.september;
      case 10:
        return AppLocalizations.of(context)!.october;
      case 11:
        return AppLocalizations.of(context)!.november;
      case 12:
        return AppLocalizations.of(context)!.december;
    }
    return "";
  }
}
