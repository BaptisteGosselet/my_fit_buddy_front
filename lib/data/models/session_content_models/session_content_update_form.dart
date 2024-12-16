class SessionContentUpdateForm {
  final int id;
  final int numberOfSet;
  final int restTimeInSecond;
  final int index;

  SessionContentUpdateForm({
    required this.id,
    required this.index,
    required this.restTimeInSecond,
    required this.numberOfSet,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'index': index,
      'restTimeInSecond': restTimeInSecond,
      'numberOfSet': numberOfSet
    };
  }
}
