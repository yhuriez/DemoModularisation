// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/domain.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../datasources/local/auth_local_datasource.dart' as _i726;
import '../datasources/remote/auth_api.dart' as _i843;
import '../repositories/auth_repository_impl.dart' as _i299;
import 'data_module.dart' as _i444;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> initData({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dataModule = _$DataModule();
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => dataModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i843.AuthApi>(() => dataModule.authApi);
    gh.lazySingleton<_i726.AuthLocalDataSource>(
      () => dataModule.authLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i494.AuthRepository>(
      () => _i299.AuthRepositoryImpl(
        gh<_i843.AuthApi>(),
        gh<_i726.AuthLocalDataSource>(),
      ),
    );
    return this;
  }
}

class _$DataModule extends _i444.DataModule {}
