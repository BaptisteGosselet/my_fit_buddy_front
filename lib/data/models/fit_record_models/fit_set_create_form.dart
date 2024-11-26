class FitSetCreateForm {
  final int idRecord;
  final int idExercise;
  final int nbOrder;
  final int nbRep;
  final int weight;

  FitSetCreateForm({
    required this.idRecord,
    required this.idExercise,
    required this.nbOrder,
    required this.nbRep,
    required this.weight,
  });

  @override
  String toString() {
    return 'FitSetCreateForm(idRecord: $idRecord, idExercise: $idExercise, nbOrder: $nbOrder, nbRep: $nbRep, weight: $weight)';
  }

  Map<String, dynamic> toJson() {
    return {
      'idRecord': idRecord,
      'idExercise': idExercise,
      'nbOrder': nbOrder,
      'nbRep': nbRep,
      'weight': weight,
    };
  }
}
