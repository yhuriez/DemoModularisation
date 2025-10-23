part of 'login_bloc.dart';

/// Événements du Bloc de connexion
sealed class LoginEvent {
  const LoginEvent();
}

/// Changement de l'email
class LoginEmailChanged extends LoginEvent {
  final String email;
  
  const LoginEmailChanged(this.email);
}

/// Changement du mot de passe
class LoginPasswordChanged extends LoginEvent {
  final String password;
  
  const LoginPasswordChanged(this.password);
}

/// Soumission du formulaire
class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

