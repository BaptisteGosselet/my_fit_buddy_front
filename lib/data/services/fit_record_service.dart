import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set_create_form.dart';

class FitRecordService {
  static const String recordsUrl = "/records";
  static const String setsUrl = "/sets";

  Future<FitRecord> createRecord() async {
    return FitRecord(id: 1, date: DateTime(2024), name: 'Toto');
  }

  Future<bool> createFitSet(
      int idRecord, int idExercise, int nbOrder, int nbRep, int weight) async {
    FitSetCreateForm form = FitSetCreateForm(
        idRecord: idRecord,
        idExercise: idExercise,
        nbOrder: nbOrder,
        nbRep: nbRep,
        weight: weight);
    print('FORM $form');
    return true;
  }
}
