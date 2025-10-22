import 'package:flutter/foundation.dart';
import 'package:domain/domain.dart';
import 'package:common/common.dart';
import 'package:injectable/injectable.dart';

/// Notifier pour gérer l'état d'authentification
/// Permet au router de réagir aux changements d'authentification
@LazySingleton(as: AuthStatusNotifier)
class AuthStatusNotifierImpl extends ChangeNotifier implements AuthStatusNotifier {
  final AuthRepository _authRepository;
  bool _isAuthenticated = false;
  
  AuthStatusNotifierImpl(this._authRepository);
  
  /// Vérifie si l'utilisateur est authentifié
  @override
  bool isAuthenticated() => _isAuthenticated;
  
  /// Initialise l'état d'authentification
  @override
  Future<void> initialize() async {
    _isAuthenticated = await _authRepository.isLoggedIn();
    notifyListeners();
  }
  
  /// Met à jour l'état d'authentification après une connexion
  @override
  void setAuthenticated(bool value) {
    if (_isAuthenticated != value) {
      _isAuthenticated = value;
      notifyListeners();
    }
  }
  
  /// Vérifie l'état actuel sans notifier
  @override
  Future<void> checkAuthStatus() async {
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (_isAuthenticated != isLoggedIn) {
      _isAuthenticated = isLoggedIn;
      notifyListeners();
    }
  }
}

