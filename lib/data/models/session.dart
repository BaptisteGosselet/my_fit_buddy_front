class Session {
  final String name;

  Session({
    required this.name,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      name: json['name'] as String,
    );
  }
}
