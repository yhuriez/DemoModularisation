part of 'login_bloc.dart';

/// État du Bloc de connexion
class LoginState extends Equatable {
  final EmailInput email;
  final PasswordInput password;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  
  const LoginState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });
  
  @override
  List<Object?> get props => [email, password, status, errorMessage];
  
  /// Copie avec modification
  LoginState copyWith({
    EmailInput? email,
    PasswordInput? password,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  /// Vérifie si le formulaire est valide
  bool get isValid => Formz.validate([email, password]);
}

