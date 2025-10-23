import 'package:formz/formz.dart';

/// Erreurs de validation pour l'email
enum EmailValidationError {
  empty,
  invalid,
}

/// Validation de l'email avec Formz
class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([super.value = '']) : super.dirty();
  
  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return EmailValidationError.invalid;
    }
    
    return null;
  }
  
  /// Message d'erreur localisé
  String? get errorMessage {
    if (isPure || isValid) return null;
    
    return switch (error) {
      EmailValidationError.empty => 'L\'email est requis',
      EmailValidationError.invalid => 'L\'email n\'est pas valide',
      null => null,
    };
  }
}

