import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';
import 'package:common/common.dart';
import '../blocs/login/login_bloc.dart';

/// Page de connexion
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Erreur de connexion'),
                  backgroundColor: AppColors.error,
                ),
              );
          } else if (state.status.isSuccess) {
            // Connexion réussie - redirection vers la liste des todos
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Connexion réussie !'),
                  backgroundColor: AppColors.success,
                ),
              );
            // Mettre à jour l'état d'authentification
            final authNotifier = getIt<AuthStatusNotifier>();
            authNotifier.checkAuthStatus().then((_) {
              // Navigation vers la page des todos après mise à jour
              // Le router détectera automatiquement l'état d'authentification
              if (context.mounted) {
                context.go('/todos');
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
                  // Logo ou titre
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Connexion',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  
                  // Champ email
                  const _EmailInput(),
                  const SizedBox(height: 16),
                  
                  // Champ mot de passe
                  const _PasswordInput(),
                  const SizedBox(height: 24),
                  
                  // Bouton de connexion
                  const _LoginButton(),
                  const SizedBox(height: 16),
                  
                  // Lien vers l'inscription
                  const _RegisterLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Champ de saisie de l'email
class _EmailInput extends StatelessWidget {
  const _EmailInput();
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
            context.read<LoginBloc>().add(LoginEmailChanged(email));
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
    return BlocBuilder<LoginBloc, LoginState>(
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
            context.read<LoginBloc>().add(LoginPasswordChanged(password));
          },
          onEditingComplete: () {
            if (state.isValid) {
              context.read<LoginBloc>().add(const LoginSubmitted());
            }
          },
        );
      },
    );
  }
}

/// Bouton de connexion
class _LoginButton extends StatelessWidget {
  const _LoginButton();
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final isLoading = state.status.isInProgress;
        
        return ElevatedButton(
          onPressed: state.isValid && !isLoading
              ? () {
                  context.read<LoginBloc>().add(const LoginSubmitted());
                }
              : null,
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Se connecter'),
        );
      },
    );
  }
}

/// Lien vers l'inscription
class _RegisterLink extends StatelessWidget {
  const _RegisterLink();
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Pas encore de compte ? ',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () {
            context.go('/register');
          },
          child: const Text('S\'inscrire'),
        ),
      ],
    );
  }
}

