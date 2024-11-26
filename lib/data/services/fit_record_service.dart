import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set_create_form.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';

class FitRecordService {
  static const String recordsUrl = "/records";
  static const String setsUrl = "/sets";

  Future<FitRecord> createRecord(String sessionId) async {
    print('$recordsUrl/create/$sessionId');
    try {
      final response = await APIService.instance.request(
        '$recordsUrl/create/$sessionId',
        DioMethod.post,
      );

      if (response.statusCode == 200) {
        return FitRecord.fromJson(response.data);
      } else {
        throw Exception('Failed to create record');
      }
    } catch (e) {
      print('Erreur lors de la création de l\'enregistrement : $e');
      return Future.error('Erreur lors de la création de l\'enregistrement');
    }
  }

  Future<bool> createFitSet(
      int idRecord, int idExercise, int nbOrder, int nbRep, int weight) async {
    try {
      FitSetCreateForm form = FitSetCreateForm(
          idRecord: idRecord,
          idExercise: idExercise,
          nbOrder: nbOrder,
          nbRep: nbRep,
          weight: weight);

      final response = await APIService.instance.request(
        '$setsUrl/create',
        DioMethod.post,
        param: form.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Erreur lors de la création de l\'ensemble : $e');
      return false;
    }
  }
}
