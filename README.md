# my_fit_buddy

MyFitBuddy est une application de prise de note en salle de sport.

## Lancer le projet

1. Récupérer les dépendances 
```sh
flutter pub get
```

2. Générer les fichiers de traduction (qui se trouveront dans `lib/l10n/`).
```sh
flutter gen-l10n
```

3. Lancer le projet 

(Alternative) Lister les émulateurs flutter : 
```sh
flutter emulators
```
Lancer un émulateur
```sh
flutter emulators --launch $nom_de_l_emulateur
#Par exemple : flutter emulators --launch Medium_Phone_API_35
``` 

Lancer `flutter run` (sur navigateur il faut préciser le web-port 8082 pour l'origine CORS de l'API locale)
```sh
flutter run --web-port=8082
```



# Architecture

L'architecture suit le modèle MVVM.

`core` : pour les configurations API 

`views` 
- `pages` : les pages complètes affichées à l'écran
- `widgets` : les composants partagés
- `themes` : les constantes liées aux thèmes (couleurs, mode sombre, etc.)

`viewmodels`

`data`
- `model`
- `services`


# Qualité de code

1. Pour formatter le code (indentations, sauts de lignes, etc.)
```sh
dart format . # à la racine du projet
```
2. Analyse des bonnes pratiques
```sh
flutter analyze
```
