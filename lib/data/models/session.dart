class Session {
  final int id;
  final String name;

  Session({
    required this.id,
    required this.name,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
