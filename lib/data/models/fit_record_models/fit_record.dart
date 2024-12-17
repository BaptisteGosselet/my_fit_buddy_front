class FitRecord {
  final int id;
  final DateTime date;
  final String name;
  final String feelingNote;
  final int feelingRate;

  FitRecord(
      {required this.id,
      required this.date,
      required this.name,
      required this.feelingNote,
      required this.feelingRate});

  factory FitRecord.fromJson(Map<String, dynamic> json) {
    return FitRecord(
        id: json['id'],
        date: DateTime.parse(json['date']),
        name: json['name'],
        feelingNote: json['feelingNote'] ?? "",
        feelingRate:
            json['feelingRate'] is int ? json['feelingRate'] as int : 0);
  }
}
