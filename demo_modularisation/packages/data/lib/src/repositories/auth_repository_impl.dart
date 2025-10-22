import 'package:common/common.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/auth_api.dart';

/// Implémentation du repository d'authentification
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final AuthLocalDataSource _localDataSource;
  
  const AuthRepositoryImpl(
    this._authApi,
    this._localDataSource,
  );
  
  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Appel à l'API
      final userModel = await _authApi.login(
        email: email,
        password: password,
      );
      
      // Sauvegarde en local
      await _localDataSource.saveCurrentUser(userModel);
      await _localDataSource.saveAuthToken('mock_token_${userModel.id}');
      
      return Success(userModel.toEntity());
    } on AuthException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(AuthException('Erreur lors de la connexion: ${e.toString()}'));
    }
  }
  
  @override
  Future<Result<User>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Appel à l'API
      final userModel = await _authApi.register(
        email: email,
        password: password,
        name: name,
      );
      
      // Sauvegarde en local
      await _localDataSource.saveCurrentUser(userModel);
      await _localDataSource.saveAuthToken('mock_token_${userModel.id}');
      
      return Success(userModel.toEntity());
    } on AuthException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(AuthException('Erreur lors de l\'inscription: ${e.toString()}'));
    }
  }
  
  @override
  Future<Result<void>> logout() async {
    try {
      await _localDataSource.clearAuthData();
      return const Success(null);
    } catch (e) {
      return Failure(AuthException('Erreur lors de la déconnexion: ${e.toString()}'));
    }
  }
  
  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      final userModel = _localDataSource.getCurrentUser();
      return Success(userModel?.toEntity());
    } catch (e) {
      return Failure(
        AuthException('Erreur lors de la récupération de l\'utilisateur: ${e.toString()}'),
      );
    }
  }
  
  @override
  Future<bool> isLoggedIn() async {
    return _localDataSource.isLoggedIn();
  }
}

