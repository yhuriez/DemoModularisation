# Todo List - Démo Modularisation

Application de démonstration d'une architecture modulaire Flutter suivant les principes de Clean Architecture.

## 📦 Structure du projet

Le projet est organisé en plusieurs packages indépendants :

### Packages Dart pur (sans Flutter)
- **common** : Utilitaires partagés (exceptions, extensions, Result, injection de dépendances)
- **domain** : Entités métier, interfaces de repositories et use cases

### Packages Flutter
- **data** : Implémentation des repositories, API simulée et stockage local (SharedPreferences)
- **ui** : Composants UI réutilisables et thème de l'application
- **feature_auth** : Module d'authentification (connexion/inscription)
- **feature_todo** : Module de gestion des todos (à implémenter)

## 🏗️ Architecture

```
┌─────────────────────────────────────┐
│      Application (main)             │
└─────────────┬───────────────────────┘
              │
    ┌─────────┴─────────────────────┐
    │                               │
┌───┴────┐  ┌──────────┐  ┌────────┴─────┐
│  data  │  │feature_  │  │  feature_    │
│        │  │  auth    │  │    todo      │
└───┬────┘  └────┬─────┘  └────┬─────────┘
    │            │              │
    │       ┌────┴──────────────┴─────┐
    │       │          ui              │
    │       └──────────┬───────────────┘
    │                  │
    └──────────────────┼────────────────┐
                       │                │
                  ┌────▼─────┐    ┌────▼────┐
                  │  domain  │    │ common  │
                  │ (Dart)   │◄───┤ (Dart)  │
                  └──────────┘    └─────────┘
```

## 🚀 Installation et exécution

### 1. Récupérer les dépendances

```bash
flutter pub get
```

### 2. Générer le code pour l'injection de dépendances

Le projet utilise `injectable` et `get_it` pour l'injection de dépendances. Il faut générer le code avec :

```bash
# Générer le code pour tous les packages
flutter pub run build_runner build --delete-conflicting-outputs

# Ou en mode watch pour la génération automatique lors des modifications
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 3. Lancer l'application

```bash
flutter run
```

## 🔧 Technologies utilisées

- **State Management** : `flutter_bloc` (BLoC pattern)
- **Injection de dépendances** : `injectable` + `get_it`
- **Validation de formulaires** : `formz`
- **Stockage local** : `shared_preferences`
- **Égalité** : `equatable`

## 📱 Fonctionnalités

### ✅ Implémenté
- Architecture modulaire avec packages indépendants
- Authentification (connexion/inscription)
- API simulée pour la démo
- Stockage local des données utilisateur
- Validation de formulaires
- Gestion d'état avec BLoC
- Thème personnalisé

### 🚧 À implémenter
- Module feature_todo (liste de tâches)
- Navigation entre les pages
- Gestion de session
- Tests unitaires et d'intégration

## 📚 Commandes utiles

### Nettoyer les fichiers générés
```bash
flutter pub run build_runner clean
```

### Analyser le code
```bash
flutter analyze
```

### Formater le code
```bash
dart format .
```

### Exécuter les tests
```bash
flutter test
```

## 🎓 Apprentissages clés

Ce projet démontre :
1. ✅ Séparation en couches (Domain, Data, Presentation)
2. ✅ Modularisation par fonctionnalités (features)
3. ✅ Injection de dépendances
4. ✅ Pattern Repository
5. ✅ Use Cases pour la logique métier
6. ✅ État typé avec BLoC
7. ✅ Gestion des erreurs avec Result
8. ✅ Validation avec Formz

## 📝 Notes

- Les packages `common` et `domain` sont des packages Dart pur (sans Flutter)
- L'API est simulée en mémoire pour les besoins de la démo
- Le stockage utilise SharedPreferences (à remplacer par une vraie base de données en production)
