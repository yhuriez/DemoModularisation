import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';

/// Builders pour les pages de l'application
/// Permet aux features de fournir leurs implémentations de pages
typedef PageBuilder = Widget Function();

/// Configuration du router de l'application
class AppRouterConfig {
  final AuthStatusNotifier authStateNotifier;
  final PageBuilder loginPageBuilder;
  final PageBuilder registerPageBuilder;
  final PageBuilder todosPageBuilder;
  
  AppRouterConfig({
    required this.authStateNotifier,
    required this.loginPageBuilder,
    required this.registerPageBuilder,
    required this.todosPageBuilder,
  });
  
  /// Crée et retourne le GoRouter configuré
  GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.root,
      refreshListenable: authStateNotifier as ChangeNotifier,
      redirect: _handleRedirect,
      routes: [
        // Route racine - redirige vers login ou todos selon l'état d'auth
        GoRoute(
          path: AppRoutes.root,
          redirect: (context, state) {
            if (authStateNotifier.isAuthenticated()) {
              return AppRoutes.todos;
            } else {
              return AppRoutes.login;
            }
          },
        ),
        
        // Route de connexion
        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: loginPageBuilder(),
          ),
        ),
        
        // Route d'inscription
        GoRoute(
          path: AppRoutes.register,
          name: 'register',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: registerPageBuilder(),
          ),
        ),
        
        // Route de la liste de todos (protégée)
        GoRoute(
          path: AppRoutes.todos,
          name: 'todos',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: todosPageBuilder(),
          ),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Page non trouvée',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.uri.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.root),
                child: const Text('Retour à l\'accueil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Gère la redirection en fonction de l'état d'authentification
  String? _handleRedirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = authStateNotifier.isAuthenticated();
    final isGoingToLogin = state.matchedLocation == AppRoutes.login;
    final isGoingToRegister = state.matchedLocation == AppRoutes.register;
    final isGoingToTodos = state.matchedLocation == AppRoutes.todos;
    
    // Si l'utilisateur n'est pas authentifié et essaie d'accéder aux todos
    // on le redirige vers la page de connexion
    if (!isAuthenticated && isGoingToTodos) {
      return AppRoutes.login;
    }
    
    // Si l'utilisateur est authentifié et essaie d'accéder à login ou register
    // on le redirige vers les todos
    if (isAuthenticated && (isGoingToLogin || isGoingToRegister)) {
      return AppRoutes.todos;
    }
    
    // Pas de redirection nécessaire
    return null;
  }
}

