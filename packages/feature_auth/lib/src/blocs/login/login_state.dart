part of 'login_bloc.dart';

/// État du Bloc de connexion
@freezed
class LoginState with _$LoginState {
  const LoginState._();
  
  const factory LoginState({
    @Default(EmailInput.pure()) EmailInput email,
    @Default(PasswordInput.pure()) PasswordInput password,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    String? errorMessage,
  }) = _LoginState;
  
  /// Vérifie si le formulaire est valide
  bool get isValid => Formz.validate([email, password]);
}

