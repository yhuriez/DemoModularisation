import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/auth_api.dart';

/// Module d'injection de dépendances pour le package data
@module
abstract class DataModule {
  /// Fournit l'instance de SharedPreferences
  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  
  /// Fournit l'API d'authentification
  @lazySingleton
  AuthApi get authApi => AuthApi();
  
  /// Fournit la source de données locale d'authentification
  @lazySingleton
  AuthLocalDataSource authLocalDataSource(SharedPreferences prefs) {
    return AuthLocalDataSource(prefs);
  }
}

