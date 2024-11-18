class Exercise {
  final int id;
  final String key;
  final String muscleGroup;
  final String labelEn;
  final String labelFr;

  Exercise({
    required this.id,
    required this.key,
    required this.muscleGroup,
    required this.labelEn,
    required this.labelFr,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      key: json['key'] as String,
      muscleGroup: json['muscleGroup'] as String,
      labelEn: json['labelEn'] as String,
      labelFr: json['labelFr'] as String,
    );
  }

  @override
  String toString() {
    return "id:$id, key:$key, muscleGroup:$muscleGroup, labelEn:$labelEn, labelFr:$labelFr";
  }
}
