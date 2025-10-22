part of 'register_bloc.dart';

/// État du Bloc d'inscription
class RegisterState extends Equatable {
  final EmailInput email;
  final PasswordInput password;
  final NameInput name;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  
  const RegisterState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.name = const NameInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });
  
  @override
  List<Object?> get props => [email, password, name, status, errorMessage];
  
  /// Copie avec modification
  RegisterState copyWith({
    EmailInput? email,
    PasswordInput? password,
    NameInput? name,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  /// Vérifie si le formulaire est valide
  bool get isValid => Formz.validate([email, password, name]);
}

