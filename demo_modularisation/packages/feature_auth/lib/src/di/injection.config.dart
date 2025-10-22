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

import '../blocs/login/login_bloc.dart' as _i614;
import '../blocs/register/register_bloc.dart' as _i137;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initFeatureAuth({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final featureAuthModule = _$FeatureAuthModule();
    gh.lazySingleton<_i494.LoginUseCase>(
      () => featureAuthModule.loginUseCase(gh<_i494.AuthRepository>()),
    );
    gh.lazySingleton<_i494.RegisterUseCase>(
      () => featureAuthModule.registerUseCase(gh<_i494.AuthRepository>()),
    );
    gh.lazySingleton<_i494.LogoutUseCase>(
      () => featureAuthModule.logoutUseCase(gh<_i494.AuthRepository>()),
    );
    gh.factory<_i137.RegisterBloc>(
      () => _i137.RegisterBloc(gh<_i494.RegisterUseCase>()),
    );
    gh.factory<_i614.LoginBloc>(
      () => _i614.LoginBloc(gh<_i494.LoginUseCase>()),
    );
    return this;
  }
}

class _$FeatureAuthModule extends _i464.FeatureAuthModule {}
