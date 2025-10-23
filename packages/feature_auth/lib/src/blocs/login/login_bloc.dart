import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import '../../models/email_input.dart';
import '../../models/password_input.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

/// Bloc de gestion de la connexion
@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  
  LoginBloc(this._loginUseCase) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }
  
  /// Gestion du changement d'email
  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = EmailInput.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }
  
  /// Gestion du changement de mot de passe
  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = PasswordInput.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }
  
  /// Gestion de la soumission du formulaire
  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) return;
    
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    
    final result = await _loginUseCase(
      email: state.email.value,
      password: state.password.value,
    );
    
    result.when(
      success: (user) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      },
      failure: (exception) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: exception.toString(),
          ),
        );
      },
    );
  }
}

