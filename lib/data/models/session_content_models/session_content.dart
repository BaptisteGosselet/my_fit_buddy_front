import 'dart:ffi';

class SessionContent {
  final Long id;
  final Long sessionId;
  final Long exerciseId;
  final int numberOfSet;
  final int restTimeInSecond;
  final int index;

  SessionContent({
    required this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.numberOfSet,
    required this.restTimeInSecond,
    required this.index,
  });

  factory SessionContent.fromJson(Map<String, dynamic> json) {
    return SessionContent(
      id: json['id'] as Long,
      sessionId: json['sessionId'] as Long,
      exerciseId: json['exerciseId'] as Long,
      numberOfSet: json['numberOfSet'] as int,
      restTimeInSecond: json['restTimeInSecond'] as int,
      index: json['index'] as int,
    );
  }
}
