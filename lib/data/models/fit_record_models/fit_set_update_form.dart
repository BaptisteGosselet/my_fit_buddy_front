class FitSetUpdateForm {
  final int idFitSet;
  final int nbOrder;
  final int nbRep;
  final int weight;

  FitSetUpdateForm({
    required this.idFitSet,
    required this.nbOrder,
    required this.nbRep,
    required this.weight,
  });

  @override
  String toString() {
    return 'FitSetUpdateForm(idFitSet: $idFitSet, nbOrder: $nbOrder, nbRep: $nbRep, weight: $weight)';
  }

  Map<String, dynamic> toJson() {
    return {
      'idFitSet': idFitSet,
      'nbOrder': nbOrder,
      'nbRep': nbRep,
      'weight': weight,
    };
  }
}
