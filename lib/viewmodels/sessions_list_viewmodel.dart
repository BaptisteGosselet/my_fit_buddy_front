import 'package:my_fit_buddy/models/session.dart';

class SessionsListViewmodel {
  List<Session> getSessionsList() {
    //En attendant l'implémentation du service
    return [
      Session(name: "Séance Full Body"),
      Session(name: "Séance Haut du Corps"),
      Session(name: "Séance Jambes"),
      Session(name: "Séance Cardio"),
      Session(name: "Séance Force"),
      Session(name: "Séance Équilibre"),
      Session(name: "Séance Abdominaux"),
      Session(name: "Séance Yoga"),
      Session(name: "Séance Pilates"),
      Session(name: "Séance Stretching"),
      Session(name: "Séance HIIT"),
      Session(name: "Séance CrossFit"),
      Session(name: "Séance Endurance"),
      Session(name: "Séance Musculation"),
      Session(name: "Séance Boxe"),
      Session(name: "Séance Danse"),
      Session(name: "Séance Zumba"),
      Session(name: "Séance Aquagym"),
      Session(name: "Séance Circuit Training"),
      Session(name: "Séance Force Athlétique"),
    ];
  }
}
