import 'dart:ffi';

class SessionContentExoKey {
  final Long id;
  final Long sessionId;
  final Long exerciseId;
  final int numberOfSet;
  final int restTimeInSecond;
  final int index;

  final String key;

  SessionContentExoKey({
    required this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.numberOfSet,
    required this.restTimeInSecond,
    required this.index,
    required this.key
  });

  factory SessionContentExoKey.fromJson(Map<String, dynamic> json) {
    return SessionContentExoKey(
      id: json['id'] as Long,
      sessionId: json['sessionId'] as Long,
      exerciseId: json['exerciseId'] as Long,
      numberOfSet: json['numberOfSet'] as int,
      restTimeInSecond: json['restTimeInSecond'] as int,
      index: json['index'] as int,
      key: json['key'] as String
    );
  }
}
