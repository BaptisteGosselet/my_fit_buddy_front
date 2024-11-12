class Exercise {
  final int id;
  final String key;
  final String muscleGroup;

  Exercise({
    required this.id,
    required this.key,
    required this.muscleGroup,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      key: json['key'] as String,
      muscleGroup: json['muscleGroup'] as String,
    );
  }

  @override
  String toString() {
    return "id:$id, key:$key, muscleGroup:$muscleGroup";
  }
}
