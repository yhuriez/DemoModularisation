import 'package:formz/formz.dart';

/// Erreurs de validation pour le mot de passe
enum PasswordValidationError {
  empty,
  tooShort,
}

/// Validation du mot de passe avec Formz
class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();
  
  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    
    if (value.length < 6) {
      return PasswordValidationError.tooShort;
    }
    
    return null;
  }
  
  /// Message d'erreur localisé
  String? get errorMessage {
    if (isPure || isValid) return null;
    
    return switch (error) {
      PasswordValidationError.empty => 'Le mot de passe est requis',
      PasswordValidationError.tooShort => 'Le mot de passe doit contenir au moins 6 caractères',
      null => null,
    };
  }
}

