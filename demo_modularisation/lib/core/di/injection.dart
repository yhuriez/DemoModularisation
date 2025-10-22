import 'package:common/common.dart';
import 'package:data/data.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_todo/feature_todo.dart';
import 'package:injectable/injectable.dart';
import 'package:ui/ui.dart';
import 'package:go_router/go_router.dart';

import 'injection.config.dart';

/// Configure toutes les dépendances de l'application
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  // Initialisation de common (GetIt)
  await configureCommonDependencies();
  
  // Initialisation de data (repositories, datasources)
  await configureDataDependencies(getIt);
  
  // Initialisation de feature_auth (blocs, use cases)
  await configureFeatureAuthDependencies(getIt);
  
  // Initialisation de ui (routing avec annotations)
  await configureUiDependencies(getIt);
  
  // Initialisation du module principal
  getIt.init();
  
  // Configuration manuelle du routing (GoRouter nécessite les page builders)
  _configureRouting();
}

/// Configure les dépendances liées au routing
/// AuthStatusNotifier est enregistré automatiquement via l'annotation @LazySingleton
/// dans le package ui. On enregistre aussi AuthStateNotifier pour pouvoir l'injecter.
void _configureRouting() {
  // Récupération de l'AuthStateNotifier
  final authStateNotifier = getIt<AuthStatusNotifier>();
  
  // Configuration du router avec les builders de pages
  final routerConfig = AppRouterConfig(
    authStateNotifier: authStateNotifier as AuthStatusNotifierImpl,
    loginPageBuilder: () => const LoginPage(),
    registerPageBuilder: () => const RegisterPage(),
    todosPageBuilder: () => const TodoListPage(),
  );
  
  // Création et enregistrement du GoRouter
  final router = routerConfig.createRouter();
  getIt.registerSingleton<GoRouter>(router);
}

