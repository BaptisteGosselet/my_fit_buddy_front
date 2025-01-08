import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/data/services/fit_record_service.dart';
import 'package:my_fit_buddy/managers/toast_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecordsViewmodel {
  final fitRecordService = FitRecordService();

  Future<List<FitRecord>> fetchUserRecords() async {
    try {
      List<FitRecord> records = await fitRecordService.getUserRecords();
      return records;
    } catch (e) {
      return Future.error(
          'Erreur lors de la récupération des enregistrements : $e');
    }
  }

  Future<FitRecord> getRecordById(int id) async {
    try {
      FitRecord record = await fitRecordService.getRecordById(id);
      return record;
    } catch (e) {
      return Future.error(
          'Erreur lors de la récupération de l\'enregistrement');
    }
  }

  Future<Map<String, List<FitSet>>> getSetByExerciceByRecordId(int id) async {
    try {
      Map<String, List<FitSet>> record =
          await fitRecordService.getSetByExerciceByRecordId(id);
      return record;
    } catch (e) {
      return Future.error(
          'Erreur lors de la récupération de l\'enregistrement');
    }
  }

  Future<bool> saveNote(
      int recordId, String feelingText, BuildContext context) async {
    if (!context.mounted) {
      return false;
    }

    if (feelingText.isEmpty) {
      if (context.mounted) {
        ToastManager.instance
            .showWarningToast(context, AppLocalizations.of(context)!.noteEmpty);
      }
      return false;
    }

    if (feelingText.length > 255) {
      if (context.mounted) {
        ToastManager.instance.showWarningToast(
            context, AppLocalizations.of(context)!.textTooBig);
      }
      return false;
    }

    bool result = await fitRecordService.setNote(recordId, feelingText);

    if (result) {
      if (context.mounted) {
        ToastManager.instance.showSuccessToast(
            context, AppLocalizations.of(context)!.noteSetSuccefully);
      }
    }

    return result;
  }
}
