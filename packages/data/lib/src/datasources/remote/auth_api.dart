import '../../models/user_model.dart';

/// API simulée pour l'authentification
class AuthApi {
  // Simulation d'une base de données en mémoire
  final Map<String, _UserCredentials> _users = {
  };
  
  /// Connexion (simulée)
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Simulation d'un délai réseau
    await Future.delayed(const Duration(seconds: 1));
    
    // Vérification des credentials
    final credentials = _users[email];
    if (credentials == null || credentials.password != password) {
      throw Exception('Email ou mot de passe incorrect');
    }
    
    return credentials.user;
  }
  
  /// Inscription (simulée)
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    // Simulation d'un délai réseau
    await Future.delayed(const Duration(seconds: 1));
    
    // Vérification si l'utilisateur existe déjà
    if (_users.containsKey(email)) {
      throw Exception('Un utilisateur avec cet email existe déjà');
    }
    
    // Création du nouvel utilisateur
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      createdAt: DateTime.now(),
    );
    
    // Sauvegarde des credentials
    _users[email] = _UserCredentials(
      user: user,
      password: password,
    );
    
    return user;
  }
  
  /// Récupération du profil utilisateur (simulée)
  Future<UserModel> getUserProfile(String userId) async {
    // Simulation d'un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Recherche de l'utilisateur
    final user = _users.values
        .firstWhere(
          (credentials) => credentials.user.id == userId,
          orElse: () => throw Exception('Utilisateur non trouvé'),
        )
        .user;
    
    return user;
  }
}

/// Classe privée pour stocker les credentials
class _UserCredentials {
  final UserModel user;
  final String password;
  
  const _UserCredentials({
    required this.user,
    required this.password,
  });
}

