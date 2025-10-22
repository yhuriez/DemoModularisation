import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';
import 'package:common/common.dart';
import '../blocs/register/register_bloc.dart';

/// Page d'inscription
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterBloc>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Erreur d\'inscription'),
                  backgroundColor: AppColors.error,
                ),
              );
          } else if (state.status.isSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Inscription réussie !'),
                  backgroundColor: AppColors.success,
                ),
              );
            // Mettre à jour l'état d'authentification avant la redirection
            final authNotifier = getIt<AuthStatusNotifier>();
            authNotifier.checkAuthStatus().then((_) {
              // Retour à la page de connexion
              if (context.mounted) {
                context.go('/login');
              }
            });
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Créer un compte',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  
                  // Champ nom
                  const _NameInput(),
                  const SizedBox(height: 16),
                  
                  // Champ email
                  const _EmailInput(),
                  const SizedBox(height: 16),
                  
                  // Champ mot de passe
                  const _PasswordInput(),
                  const SizedBox(height: 24),
                  
                  // Bouton d'inscription
                  const _RegisterButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Champ de saisie du nom
class _NameInput extends StatelessWidget {
  const _NameInput();
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Nom',
          hintText: 'Votre nom',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.person_outlined),
          errorText: state.name.errorMessage,
          onChanged: (name) {
            context.read<RegisterBloc>().add(RegisterNameChanged(name));
          },
        );
      },
    );
  }
}

/// Champ de saisie de l'email
class _EmailInput extends StatelessWidget {
  const _EmailInput();
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Email',
          hintText: 'exemple@email.com',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.email_outlined),
          errorText: state.email.errorMessage,
          onChanged: (email) {
            context.read<RegisterBloc>().add(RegisterEmailChanged(email));
          },
        );
      },
    );
  }
}

/// Champ de saisie du mot de passe
class _PasswordInput extends StatefulWidget {
  const _PasswordInput();
  
  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _obscureText = true;
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Mot de passe',
          hintText: '••••••',
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          errorText: state.password.errorMessage,
          onChanged: (password) {
            context.read<RegisterBloc>().add(RegisterPasswordChanged(password));
          },
          onEditingComplete: () {
            if (state.isValid) {
              context.read<RegisterBloc>().add(const RegisterSubmitted());
            }
          },
        );
      },
    );
  }
}

/// Bouton d'inscription
class _RegisterButton extends StatelessWidget {
  const _RegisterButton();
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        final isLoading = state.status.isInProgress;
        
        return ElevatedButton(
          onPressed: state.isValid && !isLoading
              ? () {
                  context.read<RegisterBloc>().add(const RegisterSubmitted());
                }
              : null,
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('S\'inscrire'),
        );
      },
    );
  }
}

