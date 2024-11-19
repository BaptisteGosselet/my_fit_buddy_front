class SessionContentExoKey {
  final int id;
  final int sessionId;
  final int exerciseId;
  final int numberOfSet;
  final int restTimeInSecond;
  final int index;

  final String key;

  SessionContentExoKey(
      {required this.id,
      required this.sessionId,
      required this.exerciseId,
      required this.numberOfSet,
      required this.restTimeInSecond,
      required this.index,
      required this.key});

  @override
  String toString() {
    return "$id + $sessionId + $exerciseId + $numberOfSet + $restTimeInSecond";
  }

  factory SessionContentExoKey.fromJson(Map<String, dynamic> json) {
    return SessionContentExoKey(
        id: json['id'],
        sessionId: json['sessionId'],
        exerciseId: json['exerciseId'],
        numberOfSet: json['numberOfSet'],
        restTimeInSecond: json['restTimeInSecond'],
        index: json['index'],
        key: json['key'] as String);
  }
}
