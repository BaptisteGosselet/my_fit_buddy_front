import 'package:my_fit_buddy/data/exercises/exercise.dart';
import 'package:my_fit_buddy/data/models/fit_record_models/fit_record.dart';

class FitSet {
  final int id;
  final FitRecord record;
  final Exercise exercise;
  final int nbOrder;
  final int nbRep;
  final int weight;

  FitSet({
    required this.id,
    required this.record,
    required this.exercise,
    required this.nbOrder,
    required this.nbRep,
    required this.weight,
  });

  factory FitSet.fromJson(Map<String, dynamic> json) {
    return FitSet(
      id: json['id'],
      record: FitRecord.fromJson(json['record']),
      exercise: Exercise.fromJson(json['exercise']),
      nbOrder: json['nbOrder'],
      nbRep: json['nbRep'],
      weight: json['weight'],
    );
  }

  @override
  String toString() {
    return 'FitSet(id: $id,, record: {$record}, exercise: {$exercise} nbOrder: $nbOrder, nbRep: $nbRep, weight: $weight)';
  }
}
