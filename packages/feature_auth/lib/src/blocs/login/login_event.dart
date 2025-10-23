part of 'login_bloc.dart';

/// Événements du Bloc de connexion
@freezed
class LoginEvent with _$LoginEvent {
  /// Changement de l'email
  const factory LoginEvent.emailChanged(String email) = LoginEmailChanged;
  
  /// Changement du mot de passe
  const factory LoginEvent.passwordChanged(String password) = LoginPasswordChanged;
  
  /// Soumission du formulaire
  const factory LoginEvent.submitted() = LoginSubmitted;
}

