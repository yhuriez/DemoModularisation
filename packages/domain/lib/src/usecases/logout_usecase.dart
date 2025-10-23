import 'package:common/common.dart';
import '../repositories/auth_repository.dart';

/// Use case pour la déconnexion
class LogoutUseCase {
  final AuthRepository _authRepository;
  
  const LogoutUseCase(this._authRepository);
  
  /// Exécute la déconnexion
  Future<Result<void>> call() async {
    return _authRepository.logout();
  }
}

