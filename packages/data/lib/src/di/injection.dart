import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// Configure l'injection de dépendances pour le package data
@InjectableInit(
  initializerName: 'initData',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDataDependencies(GetIt getIt) async {
  await getIt.initData();
}

