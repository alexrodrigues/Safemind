// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i409;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:safemind/features/auth/presentation/bloc/auth_bloc.dart'
    as _i885;
import 'package:safemind/features/auth/presentation/pages/auth_page.dart'
    as _i1070;
import 'package:safemind/features/home/presentation/bloc/home_bloc.dart'
    as _i36;
import 'package:safemind/features/settings/presentation/bloc/settings_bloc.dart'
    as _i522;
import 'package:safemind/services/auth_service.dart' as _i9;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i522.SettingsBloc>(() => _i522.SettingsBloc());
    gh.factory<_i9.AuthService>(() => _i9.AuthService());
    gh.factory<_i36.HomeBloc>(() => _i36.HomeBloc());
    gh.factory<_i1070.AuthPage>(() => _i1070.AuthPage(key: gh<_i409.Key>()));
    gh.factory<_i885.AuthBloc>(() => _i885.AuthBloc(gh<_i9.AuthService>()));
    return this;
  }
}
