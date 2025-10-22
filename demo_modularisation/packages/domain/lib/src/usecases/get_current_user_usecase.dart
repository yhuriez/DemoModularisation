import 'package:common/common.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case pour récupérer l'utilisateur actuel
class GetCurrentUserUseCase {
  final AuthRepository _authRepository;
  
  const GetCurrentUserUseCase(this._authRepository);
  
  /// Exécute la récupération de l'utilisateur actuel
  Future<Result<User?>> call() async {
    return _authRepository.getCurrentUser();
  }
}

