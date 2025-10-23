part of 'register_bloc.dart';

/// Événements du Bloc d'inscription
@freezed
class RegisterEvent with _$RegisterEvent {
  /// Changement de l'email
  const factory RegisterEvent.emailChanged(String email) = RegisterEmailChanged;
  
  /// Changement du mot de passe
  const factory RegisterEvent.passwordChanged(String password) = RegisterPasswordChanged;
  
  /// Changement du nom
  const factory RegisterEvent.nameChanged(String name) = RegisterNameChanged;
  
  /// Soumission du formulaire
  const factory RegisterEvent.submitted() = RegisterSubmitted;
}

