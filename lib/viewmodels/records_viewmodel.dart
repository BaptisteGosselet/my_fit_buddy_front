import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';
import 'package:my_fit_buddy/data/services/fit_record_service.dart';

class RecordsViewmodel {
  final fitRecordService = FitRecordService();

  Future<List<FitRecord>> fetchUserRecords() async {
    try {
      List<FitRecord> records = await fitRecordService.getUserRecords();
      print('Records récupérés : $records');
      return records;
    } catch (e) {
      print('Erreur lors de la récupération des enregistrements : $e');
      return Future.error(
          'Erreur lors de la récupération des enregistrements : $e');
    }
  }

  Future<FitRecord> getRecordById(int id) async {
    try {
      FitRecord record = await fitRecordService.getRecordById(id);
      return record;
    } catch (e) {
      print('Erreur lors de la récupération de l\'enregistrement par id : $e');
      return Future.error(
          'Erreur lors de la récupération de l\'enregistrement');
    }
  }
}
