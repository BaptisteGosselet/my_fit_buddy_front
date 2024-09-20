# my_fit_buddy

MyFitBuddy est une application de prise de note en salle de sport.

## Lancer le projet

1. Récupérer les dépendances 
```sh
flutter pub get
```

1. Lancer le projet 
```sh
flutter run
```

# Architecture

L'architecture suit grossièrement le modèle MVVM.

`views` 
- `pages` : contient les pages complètes affichées à l'écran
- `widgets` : contient les composants partagés
- `themes` : contient les constantes liées aux thèmes (couleurs, mode sombre, etc.)

`models`
- ... contiendra les modèles

`viewmodels`
- ... contiendra les viewmodels

`services`
- ... contiendra les services

# Qualité de code

1. Pour formatter le code (indentations, sauts de lignes, etc.)
```sh
dart format . # à la racine du projet
```
2. Analyse des bonnes pratiques
```sh
flutter analyze
```

# Traduction

La traduction est installée sur ce projet, les fichiers se trouvent dans `lib/l10n/`.
Ensuite, pour générer les fichiers de traductions : 
```sh
flutter gen-l10n
```