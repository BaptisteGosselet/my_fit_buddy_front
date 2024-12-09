class SessionUpdateForm {
  final int sessionId;
  final String name;

  SessionUpdateForm({
    required this.sessionId,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'name': name,
    };
  }
}
