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

### 1. Installer Melos (si ce n'est pas déjà fait)

Ce projet utilise **Melos 6.3.3** pour gérer le monorepo et mutualiser les opérations sur tous les packages.

```bash
dart pub global activate melos 6.3.3
```

### 2. Récupérer les dépendances

```bash
melos bootstrap
```

Cette commande va récupérer les dépendances pour tous les packages et créer les liens nécessaires.

### 3. Générer le code pour l'injection de dépendances

Le projet utilise `injectable` et `get_it` pour l'injection de dépendances. Il faut générer le code avec :

```bash
# Générer le code pour tous les packages en une seule commande
melos build

# Ou en mode watch pour la génération automatique lors des modifications
melos watch
```

### 4. Lancer l'application

```bash
flutter run
```

> 💡 **Note** : Voir [MELOS.md](MELOS.md) pour plus de détails sur l'utilisation de Melos.

## 🔧 Technologies utilisées

- **State Management** : `flutter_bloc` (BLoC pattern)
- **Injection de dépendances** : `injectable` + `get_it`
- **Validation de formulaires** : `formz`
- **Stockage local** : `shared_preferences`
- **Égalité** : `equatable`
- **Gestion de monorepo** : `melos` 6.3.3

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

## 📚 Commandes utiles avec Melos

### Générer le code (build_runner)
```bash
# Génération unique
melos build

# Mode watch
melos watch

# Nettoyer les fichiers générés
melos build:clean
```

### Gestion des packages
```bash
# Récupérer les dépendances
melos bootstrap

# Nettoyer tous les packages
melos clean
```

### Qualité du code
```bash
# Analyser le code
melos analyze

# Formater le code
melos format

# Vérifier le formatage
melos format:check

# Exécuter les tests
melos test

# Lancer tous les checks avant un commit
melos check
```

> 📖 Consultez [MELOS.md](MELOS.md) pour la documentation complète des commandes Melos disponibles.

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
