import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// Instance globale de GetIt pour l'injection de dépendances
final getIt = GetIt.instance;

/// Configure l'injection de dépendances
@InjectableInit()
Future<void> configureCommonDependencies() async {
  getIt.init();
}

