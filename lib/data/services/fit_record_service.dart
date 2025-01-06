import 'package:my_fit_buddy/core/http/http.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record_note_form.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set_create_form.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_set_update_form.dart';

class FitRecordService {
  static const String recordsUrl = "/records";
  static const String setsUrl = "/sets";

  Future<List<FitRecord>> getUserRecords() async {
    try {
      final response = await Http.instance.request(
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
      final response = await Http.instance.request(
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

  Future<Map<String, List<FitSet>>> getSetByExerciceByRecordId(
      int recordId) async {
    try {
      final response = await Http.instance.request(
        '$setsUrl/recordByExo/$recordId',
        DioMethod.get,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        Map<String, List<FitSet>> returnData = {};
        data.forEach((key, value) {
          if (value is List) {
            returnData[key] = value
                .map((json) => FitSet.fromJson(json as Map<String, dynamic>))
                .toList();
          } else {
            throw Exception(
                "La valeur associée à la clé '$key' n'est pas une liste.");
          }
        });
        return returnData;
      } else {
        throw Exception('Failed to fetch record by id');
      }
    } catch (e) {
      print('Erreur lors de la récupération de l\'enregistrement par id : $e');
      return Future.error('Erreur lors de la récupération des sets');
    }
  }

  Future<FitRecord> createRecord(String sessionId) async {
    print('$recordsUrl/create/$sessionId');
    try {
      final response = await Http.instance.request(
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

      final response = await Http.instance.request(
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

      final response = await Http.instance.request(
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

  Future<List<FitSet>> getExercisePreviousSets(int idExercise) async {
    print("SERVICE GET PREVIOUS $idExercise SETS");
    try {
      final response = await Http.instance.request(
        '$setsUrl/exerciseSet/$idExercise',
        DioMethod.get,
      );

      if (response.statusCode == 200) {
        List<dynamic> dataList = response.data;
        List<FitSet> sets =
            dataList.map((elem) => FitSet.fromJson(elem)).toList();

        return sets;
      } else {
        throw Exception('Failed to fetch previous sets for exercise');
      }
    } catch (e) {
      print(e);
      return Future.error('Erreur lors de la récupération des sets');
    }
  }

  Future<List<FitSet>> getExercisePreviousSetsByNOrder(
      int idExercise, int nbOrder) async {
    print("SERVICE GET PREVIOUS $idExercise $nbOrder SETS");
    try {
      final response = await Http.instance.request(
        '$setsUrl/exerciseSet/$idExercise/$nbOrder',
        DioMethod.get,
      );

      if (response.statusCode == 200) {
        List<dynamic> dataList = response.data;
        List<FitSet> sets =
            dataList.map((elem) => FitSet.fromJson(elem)).toList();

        return sets;
      } else {
        throw Exception('Failed to fetch previous sets for exercise');
      }
    } catch (e) {
      print(e);
      return Future.error('Erreur lors de la récupération des sets');
    }
  }

  Future<bool> setNote(int recordId, String text, int rate) async {
    try {
      print("$recordId, '$text', $rate");
      final form = FitRecordNoteForm(text: text, rate: rate);

      final response = await Http.instance.request(
        '$recordsUrl/note/$recordId',
        DioMethod.post,
        param: form.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print(
            'Échec de l\'ajout de la note : Code de statut ${response.statusCode}, Message : ${response.data}');
        throw Exception('Failed to set note for record');
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de la note : $e');
      return Future.error('Erreur lors de l\'ajout de la note');
    }
  }
}
