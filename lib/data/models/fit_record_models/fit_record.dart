class FitRecord {
  final int id;
  final DateTime date;
  final String name;

  FitRecord({
    required this.id,
    required this.date,
    required this.name,
  });

  factory FitRecord.fromJson(Map<String, dynamic> json) {
    return FitRecord(id: json['id'], date: json['date'], name: json['name']);
  }
}
