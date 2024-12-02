import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';

class FitSet {
  final int id;
  final int nbOrder;
  final int nbRep;
  final int weight;
  final int feeling;
  final FitRecord record;

  FitSet({
    required this.id,
    required this.nbOrder,
    required this.nbRep,
    required this.weight,
    required this.feeling,
    required this.record,
  });

  factory FitSet.fromJson(Map<String, dynamic> json) {
    return FitSet(
      id: json['id'],
      nbOrder: json['nbOrder'],
      nbRep: json['nbRep'],
      weight: json['weight'],
      feeling: json['feeling'],
      record: FitRecord.fromJson(json['record']),
    );
  }

  @override
  String toString() {
    return 'FitSet(id: $id, nbOrder: $nbOrder, nbRep: $nbRep, weight: $weight, feeling: $feeling, record: $record)';
  }
}
