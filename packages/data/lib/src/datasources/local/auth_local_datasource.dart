import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/user_model.dart';

/// Source de données locale pour l'authentification
class AuthLocalDataSource {
  static const String _keyCurrentUser = 'current_user';
  static const String _keyAuthToken = 'auth_token';
  
  final SharedPreferences _prefs;
  
  const AuthLocalDataSource(this._prefs);
  
  /// Sauvegarde l'utilisateur actuel
  Future<void> saveCurrentUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(_keyCurrentUser, userJson);
  }
  
  /// Récupère l'utilisateur actuel
  UserModel? getCurrentUser() {
    final userJson = _prefs.getString(_keyCurrentUser);
    if (userJson == null) return null;
    
    final userMap = jsonDecode(userJson) as Map<String, dynamic>;
    return UserModel.fromJson(userMap);
  }
  
  /// Sauvegarde le token d'authentification
  Future<void> saveAuthToken(String token) async {
    await _prefs.setString(_keyAuthToken, token);
  }
  
  /// Récupère le token d'authentification
  String? getAuthToken() {
    return _prefs.getString(_keyAuthToken);
  }
  
  /// Supprime toutes les données d'authentification
  Future<void> clearAuthData() async {
    await _prefs.remove(_keyCurrentUser);
    await _prefs.remove(_keyAuthToken);
  }
  
  /// Vérifie si un utilisateur est connecté
  bool isLoggedIn() {
    return _prefs.getString(_keyAuthToken) != null;
  }
}

