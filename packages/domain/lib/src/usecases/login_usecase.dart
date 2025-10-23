import 'package:common/common.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case pour la connexion
class LoginUseCase {
  final AuthRepository _authRepository;
  
  const LoginUseCase(this._authRepository);
  
  /// Exécute la connexion
  Future<Result<User>> call({
    required String email,
    required String password,
  }) async {
    // Validation des entrées
    if (email.isBlank) {
      return const Failure(ValidationException('L\'email est requis'));
    }
    
    if (!email.isValidEmail) {
      return const Failure(ValidationException('L\'email n\'est pas valide'));
    }
    
    if (password.isBlank) {
      return const Failure(ValidationException('Le mot de passe est requis'));
    }
    
    if (!password.isValidPassword) {
      return const Failure(
        ValidationException('Le mot de passe doit contenir au moins 6 caractères'),
      );
    }
    
    // Appel au repository
    return _authRepository.login(email: email, password: password);
  }
}

