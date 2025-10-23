part of 'register_bloc.dart';

/// Événements du Bloc d'inscription
sealed class RegisterEvent {
  const RegisterEvent();
}

/// Changement de l'email
class RegisterEmailChanged extends RegisterEvent {
  final String email;
  
  const RegisterEmailChanged(this.email);
}

/// Changement du mot de passe
class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  
  const RegisterPasswordChanged(this.password);
}

/// Changement du nom
class RegisterNameChanged extends RegisterEvent {
  final String name;
  
  const RegisterNameChanged(this.name);
}

/// Soumission du formulaire
class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}

