import 'package:formz/formz.dart';

/// Erreurs de validation pour le nom
enum NameValidationError {
  empty,
  tooShort,
}

/// Validation du nom avec Formz
class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([super.value = '']) : super.dirty();
  
  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    }
    
    if (value.length < 2) {
      return NameValidationError.tooShort;
    }
    
    return null;
  }
  
  /// Message d'erreur localisé
  String? get errorMessage {
    if (isPure || isValid) return null;
    
    return switch (error) {
      NameValidationError.empty => 'Le nom est requis',
      NameValidationError.tooShort => 'Le nom doit contenir au moins 2 caractères',
      null => null,
    };
  }
}

