import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/domain.dart';

import 'injection.config.dart';

/// Configure l'injection de dépendances pour le package feature_auth
@InjectableInit(
  initializerName: 'initFeatureAuth',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureFeatureAuthDependencies(GetIt getIt) async {
  getIt.initFeatureAuth();
}

/// Module d'injection de dépendances pour feature_auth
@module
abstract class FeatureAuthModule {
  /// Fournit le use case de connexion
  @lazySingleton
  LoginUseCase loginUseCase(AuthRepository authRepository) {
    return LoginUseCase(authRepository);
  }
  
  /// Fournit le use case d'inscription
  @lazySingleton
  RegisterUseCase registerUseCase(AuthRepository authRepository) {
    return RegisterUseCase(authRepository);
  }
  
  /// Fournit le use case de déconnexion
  @lazySingleton
  LogoutUseCase logoutUseCase(AuthRepository authRepository) {
    return LogoutUseCase(authRepository);
  }
}

