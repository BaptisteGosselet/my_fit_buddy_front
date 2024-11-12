class Exercise {
  final String key;
  final String muscleGroup;

  Exercise({
    required this.key,
    required this.muscleGroup,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      key: json['key'] as String,
      muscleGroup: json['muscleGroup'] as String,
    );
  }
}
