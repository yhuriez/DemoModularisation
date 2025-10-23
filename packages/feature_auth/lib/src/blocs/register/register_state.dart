part of 'register_bloc.dart';

/// État du Bloc d'inscription
@freezed
class RegisterState with _$RegisterState {
  const RegisterState._();
  
  const factory RegisterState({
    @Default(EmailInput.pure()) EmailInput email,
    @Default(PasswordInput.pure()) PasswordInput password,
    @Default(NameInput.pure()) NameInput name,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    String? errorMessage,
  }) = _RegisterState;
  
  /// Vérifie si le formulaire est valide
  bool get isValid => Formz.validate([email, password, name]);
}

