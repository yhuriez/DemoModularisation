/// Interface pour notifier les changements d'état d'authentification
/// Utilisée pour la navigation et la gestion de l'état global
abstract class AuthStatusNotifier {

  /// Initialise l'état d'authentification
  Future<void> initialize();

  /// Vérifie et met à jour l'état d'authentification
  Future<void> checkAuthStatus();
  
  /// Met à jour l'état d'authentification manuellement
  void setAuthenticated(bool value);

  /// Vérifie si l'utilisateur est authentifié
  bool isAuthenticated();
}

