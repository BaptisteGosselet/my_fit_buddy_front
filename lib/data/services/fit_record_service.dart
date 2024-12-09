import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set_create_form.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set_update_form.dart';
import 'package:my_fit_buddy/data/services/api_service.dart';

class FitRecordService {
  static const String recordsUrl = "/records";
  static const String setsUrl = "/sets";

  Future<List<FitRecord>> getUserRecords() async {
    try {
      final response = await APIService.instance.request(
        '$recordsUrl/user',
        DioMethod.get,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => FitRecord.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch records of user');
      }
    } catch (e) {
      print(
          'Erreur lors de la récupération des enregistrements de l\'utilisateur : $e');
      return Future.error('Erreur lors de la récupération des enregistrements');
    }
  }

  Future<FitRecord> getRecordById(int recordId) async {
    try {
      final response = await APIService.instance.request(
        '$recordsUrl/$recordId',
        DioMethod.get,
      );

      if (response.statusCode == 200) {
        return FitRecord.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch record by id');
      }
    } catch (e) {
      print('Erreur lors de la récupération de l\'enregistrement par id : $e');
      return Future.error(
          'Erreur lors de la récupération de l\'enregistrement');
    }
  }

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

  Future<FitSet> createFitSet(
      int idRecord, int idExercise, int nbOrder, int nbRep, int weight) async {
    print("CREATE SET : $idRecord, $idExercise, $nbOrder, $nbRep, $weight");

    try {
      FitSetCreateForm form = FitSetCreateForm(
        idRecord: idRecord,
        idExercise: idExercise,
        nbOrder: nbOrder,
        nbRep: nbRep,
        weight: weight,
      );

      final response = await APIService.instance.request(
        '$setsUrl/create',
        DioMethod.post,
        param: form.toJson(),
      );

      if (response.statusCode == 201) {
        return FitSet.fromJson(response.data);
      } else {
        print(
            'Échec de la création : Code de statut ${response.statusCode}, Message : ${response.data}');
      }
    } catch (e) {
      print('Erreur lors de la création de l\'ensemble : $e');
    }
    return Future.error('Erreur lors de la récupération du set');
  }

  Future<FitSet> updateFitSet(
      int idFitSet, int nbOrder, int nbRep, int weight) async {
    print("UPDATE SET : $idFitSet, $nbOrder, $nbRep, $weight");

    try {
      FitSetUpdateForm form = FitSetUpdateForm(
        idFitSet: idFitSet,
        nbOrder: nbOrder,
        nbRep: nbRep,
        weight: weight,
      );

      final response = await APIService.instance.request(
        '$setsUrl/update',
        DioMethod.put,
        param: form.toJson(),
      );

      if (response.statusCode == 200) {
        return FitSet.fromJson(response.data);
      } else {
        print(
            'Échec de la création : Code de statut ${response.statusCode}, Message : ${response.data}');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour de l\'ensemble : $e');
    }
    return Future.error('Erreur lors de la récupération du set');
  }
}
