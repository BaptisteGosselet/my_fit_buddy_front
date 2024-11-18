import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class MuscleGroupsUtils {
  static final List<String> muscleGroups = [
    'PECTORALS',
    'BACK',
    'LEGS',
    'SHOULDERS',
    'ARMS',
    'ABS'
  ];

  static String translateMuscle(BuildContext context, String muscle) {
    switch (muscle.toLowerCase()) {
      case 'pectorals':
        return AppLocalizations.of(context)!.pectorals;
      case 'back':
        return AppLocalizations.of(context)!.back;
      case 'legs':
        return AppLocalizations.of(context)!.legs;
      case 'shoulders':
        return AppLocalizations.of(context)!.shoulders;
      case 'arms':
        return AppLocalizations.of(context)!.arms;
      case 'abs':
        return AppLocalizations.of(context)!.abs;
      default:
        return muscle;
    }
  }
}
