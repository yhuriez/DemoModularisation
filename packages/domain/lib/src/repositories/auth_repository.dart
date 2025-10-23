import 'package:common/common.dart';
import '../entities/user.dart';

/// Interface du repository d'authentification
abstract class AuthRepository {
  /// Connexion avec email et mot de passe
  Future<Result<User>> login({
    required String email,
    required String password,
  });
  
  /// Inscription d'un nouvel utilisateur
  Future<Result<User>> register({
    required String email,
    required String password,
    required String name,
  });
  
  /// Déconnexion
  Future<Result<void>> logout();
  
  /// Récupération de l'utilisateur actuel
  Future<Result<User?>> getCurrentUser();
  
  /// Vérification si un utilisateur est connecté
  Future<bool> isLoggedIn();
}

