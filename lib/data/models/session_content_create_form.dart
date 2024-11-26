class SessionContentCreateForm {
  final int sessionId;
  final int exerciseId;
  final int numberOfSet;
  final int restTimeInSecond;

  SessionContentCreateForm({
    required this.sessionId,
    required this.exerciseId,
    required this.numberOfSet,
    required this.restTimeInSecond,
  });

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'exerciseId': exerciseId,
      'numberOfSet': numberOfSet,
      'restTimeInSecond': restTimeInSecond,
    };
  }
}
