import 'package:flutter/material.dart';
import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/data/models/session_content_models/session_content_exercise.dart';
import 'package:my_fit_buddy/data/services/fit_record_service.dart';
import 'package:my_fit_buddy/data/services/session_content_service.dart';
import 'package:my_fit_buddy/managers/toast_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LiveSessionViewModel {
  // Fields
  final String sessionId;
  final sessionContentService = SessionContentService();
  final fitRecordService = FitRecordService();

  int idxExercise = 0;
  int idxSet = 0;

  late FitRecord currentRecord;
  late List<SessionContentExercise> sessionContentExerciseList;
  late List<List<int>> setIdsArray;

  final int emptySetValue = -1;

  // Constructor
  LiveSessionViewModel(this.sessionId);

  // Initialization
  Future<bool> init() async {
    idxExercise = 0;
    idxSet = 0;

    sessionContentExerciseList =
        await sessionContentService.getSessionContents(sessionId);
    currentRecord = await fitRecordService.createRecord(sessionId);

    if (sessionContentExerciseList.isEmpty) {
      return false;
    }

    // Initialize setIdsArray without list comprehension
    setIdsArray = [];
    for (var exercise in sessionContentExerciseList) {
      List<int> innerList = [];
      for (int i = 0; i < exercise.getNumberOfSets(); i++) {
        innerList.add(emptySetValue);
      }
      setIdsArray.add(innerList);
    }

    return true;
  }

  // Getters for current indices and exercises
  SessionContentExercise getCurrentSessionContentExercise() {
    return sessionContentExerciseList[idxExercise];
  }

  FitRecord getRecord() => currentRecord;
  int getCurrentSetIndex() => idxSet;
  int getCurrentExerciseIndex() => idxExercise;

  // Setters for indices
  void setFitSetIndex(int n) => idxSet = n;
  void setExerciseIndex(int n) => idxExercise = n;

  Future<void> saveRecord(
      SessionContentExercise sessionContentExercise, int reps, int kg) async {
    int idSetToUpdate = setIdsArray[idxExercise][idxSet];
    FitSet savedSet;

    if (idSetToUpdate == emptySetValue) {
      // Créer un nouveau set
      savedSet = await fitRecordService.createFitSet(
        currentRecord.id,
        sessionContentExercise.exercise.id,
        idxSet + 1,
        reps,
        kg,
      );
    } else {
      // Mettre à jour un existant
      savedSet = await fitRecordService.updateFitSet(
        idSetToUpdate,
        idxSet + 1,
        reps,
        kg,
      );
    }

    // Met à jour l'ID dans la matrice
    setIdsArray[idxExercise][idxSet] = savedSet.id;
  }

  bool next() {
    // Vérifier si l'exercice courant a encore des sets non faits
    if (idxExercise >= 0 && idxExercise < sessionContentExerciseList.length) {
      final SessionContentExercise currentExercise =
          sessionContentExerciseList[idxExercise];
      for (int j = 0; j < currentExercise.getNumberOfSets(); j++) {
        if (setIdsArray[idxExercise][j] == emptySetValue) {
          idxSet = j;
          return true;
        }
      }
    }

    // Si tous les sets de l'exercice courant sont terminés, passer aux autres exercices
    for (int i = 0; i < sessionContentExerciseList.length; i++) {
      int exerciseIndex =
          (idxExercise + 1 + i) % sessionContentExerciseList.length;
      final SessionContentExercise exercise =
          sessionContentExerciseList[exerciseIndex];

      for (int j = 0; j < exercise.getNumberOfSets(); j++) {
        if (setIdsArray[exerciseIndex][j] == emptySetValue) {
          idxExercise = exerciseIndex;
          idxSet = j;
          return true;
        }
      }
    }

    // Si aucun set non fait n'existe, la session est terminée
    return false;
  }

  // Get list of exercises
  List<Exercise> getExercisesList() {
    return sessionContentExerciseList
        .map((sessionContent) => sessionContent.getExercise())
        .toList();
  }

  Future<List<FitSet>> getExercisePreviousSets() async {
    final int idExercise = getCurrentSessionContentExercise().exercise.id;
    final int nbOrder = idxSet + 1;
    List<FitSet> exercisePreviousSets = await fitRecordService
        .getExercisePreviousSetsByNOrder(idExercise, nbOrder);
    return exercisePreviousSets;
  }

  Future<bool> setNote(String text, BuildContext context) async {
    if (!context.mounted) {
      return false;
    }
    if (text.length > 255) {
      if (context.mounted) {
        ToastManager.instance
            .showErrorToast(context, AppLocalizations.of(context)!.max255char);
      }
      return false;
    }

    bool result = await fitRecordService.setNote(currentRecord.id, text);
    if (result && text.isNotEmpty) {
      if (context.mounted) {
        ToastManager.instance.showSuccessToast(
            context, AppLocalizations.of(context)!.defaultSuccess);
      }
    }

    return result;
  }

  bool isCurrentExerciseSetEmpty(int setNumber) {
    return setIdsArray[idxExercise][setNumber] == emptySetValue;
  }

  Future<FitSet?> getLastSetEntry() async {
    int lastEntrySetIndex;
    if (idxSet >= 1) {
      lastEntrySetIndex = setIdsArray[idxExercise][idxSet - 1];
    } else if (idxExercise >= 1) {
      lastEntrySetIndex = setIdsArray[idxExercise - 1][idxSet];
    } else {
      return null;
    }

    FitSet? lastEntrySet = await fitRecordService.getSetById(lastEntrySetIndex);
    return lastEntrySet;
  }
}
