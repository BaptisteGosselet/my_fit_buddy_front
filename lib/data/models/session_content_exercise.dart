import 'package:my_fit_buddy/data/exercises/exercise.dart';

class SessionContentExercise {
  final int id;
  final int sessionId;
  final Exercise exercise;
  final int numberOfSet;
  final int restTimeInSecond;
  final int index;

  SessionContentExercise({
    required this.id,
    required this.sessionId,
    required this.exercise,
    required this.numberOfSet,
    required this.restTimeInSecond,
    required this.index,
  });

  @override
  String toString() {
    return "$id + $sessionId + $exercise + $numberOfSet + $restTimeInSecond";
  }

  factory SessionContentExercise.fromJson(Map<String, dynamic> json) {
    return SessionContentExercise(
        id: json['id'],
        sessionId: json['sessionId'],
        exercise: Exercise.fromJson(json['exercise']),
        numberOfSet: json['numberOfSet'],
        restTimeInSecond: json['restTimeInSecond'],
        index: json['index']);
  }
}
