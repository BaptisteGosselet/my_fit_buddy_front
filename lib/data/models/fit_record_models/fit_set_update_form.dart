class FitSetUpdateForm {
  final int idFitSet;
  final int idExercise;
  final int nbOrder;
  final int nbRep;
  final int weight;

  FitSetUpdateForm({
    required this.idFitSet,
    required this.idExercise,
    required this.nbOrder,
    required this.nbRep,
    required this.weight,
  });

  @override
  String toString() {
    return 'FitSetUpdateForm(idFitSet: $idFitSet, idExercise: $idExercise, nbOrder: $nbOrder, nbRep: $nbRep, weight: $weight)';
  }

  Map<String, dynamic> toJson() {
    return {
      'idFitSet': idFitSet,
      'idExercise': idExercise,
      'nbOrder': nbOrder,
      'nbRep': nbRep,
      'weight': weight,
    };
  }
}
