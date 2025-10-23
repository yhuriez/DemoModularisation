import 'package:common/common.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case pour l'inscription
class RegisterUseCase {
  final AuthRepository _authRepository;
  
  const RegisterUseCase(this._authRepository);
  
  /// Exécute l'inscription
  Future<Result<User>> call({
    required String email,
    required String password,
    required String name,
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
    
    if (name.isBlank) {
      return const Failure(ValidationException('Le nom est requis'));
    }
    
    if (name.length < 2) {
      return const Failure(
        ValidationException('Le nom doit contenir au moins 2 caractères'),
      );
    }
    
    // Appel au repository
    return _authRepository.register(
      email: email,
      password: password,
      name: name,
    );
  }
}

