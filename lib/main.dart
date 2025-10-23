import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';
import 'core/di/injection.dart';

void main() async {
  // Initialisation de Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configuration de l'injection de dépendances
  await configureDependencies();
  
  // Initialisation de l'état d'authentification
  final authStateNotifier = getIt<AuthStatusNotifier>();
  await authStateNotifier.initialize();
  
  runApp(const MyApp());
}

/// Widget principal de l'application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<GoRouter>();
    
    return MaterialApp.router(
      title: 'Todo List - Démo Modularisation',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}
