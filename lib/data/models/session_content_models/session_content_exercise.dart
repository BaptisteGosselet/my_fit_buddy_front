import 'package:my_fit_buddy/data/exercises/exercise.dart';

class SessionContentExercise {
  final int id;
  final int sessionId;
  final Exercise exercise;
  final int numberOfSets;
  final int restTimeInSecond;
  final int index;

  SessionContentExercise({
    required this.id,
    required this.sessionId,
    required this.exercise,
    required this.numberOfSets,
    required this.restTimeInSecond,
    required this.index,
  });

  @override
  String toString() {
    return "$id $sessionId $exercise $numberOfSets $restTimeInSecond";
  }

  factory SessionContentExercise.fromJson(Map<String, dynamic> json) {
    return SessionContentExercise(
        id: json['id'],
        sessionId: json['sessionId'],
        exercise: Exercise.fromJson(json['exercise']),
        numberOfSets: json['numberOfSet'],
        restTimeInSecond: json['restTimeInSecond'],
        index: json['index']);
  }

  Exercise getExercise() {
    return exercise;
  }

  int getNumberOfSets() {
    return numberOfSets;
  }
}
