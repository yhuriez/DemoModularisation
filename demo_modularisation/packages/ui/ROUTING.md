# Configuration du Routing

## Vue d'ensemble

Le routing de l'application est centralisé dans le package `ui` et utilise `go_router` pour gérer la navigation de manière transverse dans toute l'application.

## Architecture

### Structure des fichiers

```
packages/ui/lib/src/routing/
├── app_routes.dart           # Définition des chemins de routes
├── auth_state_notifier.dart  # Gestion de l'état d'authentification
└── app_router_config.dart    # Configuration du GoRouter
```

### Composants principaux

#### 1. AppRoutes
Définit tous les chemins de routes de l'application :
- `/login` - Page de connexion
- `/register` - Page d'inscription
- `/todos` - Liste des tâches (protégée)
- `/` - Route racine (redirige selon l'état d'auth)

#### 2. AuthStateNotifier
Gère l'état d'authentification et notifie le router des changements :
- Implémente `ChangeNotifier` pour notifier les listeners
- Implémente `AuthStatusNotifier` pour permettre aux features de mettre à jour l'état
- Méthodes principales :
  - `initialize()` - Initialise l'état au démarrage
  - `checkAuthStatus()` - Vérifie et met à jour l'état d'authentification
  - `setAuthenticated(bool)` - Définit manuellement l'état

#### 3. AppRouterConfig
Configure le GoRouter avec :
- Les routes de l'application
- Les builders de pages (fournis par les features)
- La logique de redirection basée sur l'authentification
- La page d'erreur 404

## Utilisation

### Configuration dans le projet principal

```dart
// Dans lib/core/di/injection.dart

void _configureRouting() {
  final authRepository = getIt<AuthRepository>();
  final authStateNotifier = AuthStateNotifier(authRepository);
  
  // Enregistrer le notifier pour les features
  getIt.registerSingleton<AuthStatusNotifier>(authStateNotifier);
  
  // Configurer le router avec les builders de pages
  final routerConfig = AppRouterConfig(
    authStateNotifier: authStateNotifier,
    loginPageBuilder: () => const LoginPage(),
    registerPageBuilder: () => const RegisterPage(),
    todosPageBuilder: () => const TodoListPage(),
  );
  
  // Créer et enregistrer le GoRouter
  final router = routerConfig.createRouter();
  getIt.registerSingleton<GoRouter>(router);
}
```

### Utilisation dans les features

#### Navigation
```dart
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

// Navigation simple
context.go(AppRoutes.todos);

// Navigation avec remplacement
context.replace(AppRoutes.login);
```

#### Mise à jour de l'état d'authentification
```dart
import 'package:common/common.dart';

// Après une connexion/déconnexion réussie
final authNotifier = getIt<AuthStatusNotifier>();
await authNotifier.checkAuthStatus();
```

## Flux de redirection

### Utilisateur non authentifié
1. Tentative d'accès à `/todos` → Redirigé vers `/login`
2. Accès à `/login` ou `/register` → Autorisé

### Utilisateur authentifié
1. Accès à `/todos` → Autorisé
2. Tentative d'accès à `/login` ou `/register` → Redirigé vers `/todos`

### Déconnexion
1. L'utilisateur clique sur le bouton de déconnexion
2. Le `LogoutUseCase` est appelé
3. `authNotifier.checkAuthStatus()` met à jour l'état
4. L'utilisateur est redirigé vers `/login`
5. Le router détecte le changement d'état et empêche l'accès aux routes protégées

## Avantages de cette architecture

1. **Centralisation** : Toute la logique de routing est dans le package `ui`
2. **Réutilisabilité** : Les features peuvent utiliser le routing sans le reconfigurer
3. **Flexibilité** : Les pages sont fournies via des builders, permettant l'injection de dépendances
4. **Réactivité** : Le router réagit automatiquement aux changements d'authentification
5. **Modularité** : Chaque feature reste indépendante tout en utilisant le même système de navigation

