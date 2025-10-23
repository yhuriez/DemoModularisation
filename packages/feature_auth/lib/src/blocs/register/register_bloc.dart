import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import '../../models/email_input.dart';
import '../../models/password_input.dart';
import '../../models/name_input.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

/// Bloc de gestion de l'inscription
@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  
  RegisterBloc(this._registerUseCase) : super(const RegisterState()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }
  
  /// Gestion du changement d'email
  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
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
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = PasswordInput.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }
  
  /// Gestion du changement de nom
  void _onNameChanged(
    RegisterNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final name = NameInput.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }
  
  /// Gestion de la soumission du formulaire
  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (!state.isValid) return;
    
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    
    final result = await _registerUseCase(
      email: state.email.value,
      password: state.password.value,
      name: state.name.value,
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

