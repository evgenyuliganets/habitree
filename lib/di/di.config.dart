// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:habitree/data/data_sources/auth/remote/auth_remote_datasource.dart'
    as _i11;
import 'package:habitree/data/data_sources/auth/remote/auth_remote_datasource_impl.dart'
    as _i966;
import 'package:habitree/domain/repositories/auth/auth_repository.dart'
    as _i247;
import 'package:habitree/domain/repositories/auth/auth_repository_impl.dart'
    as _i773;
import 'package:habitree/domain/usecases/auth/sign_in_with_google_usecase.dart'
    as _i341;
import 'package:habitree/domain/usecases/auth/sign_out_usecase.dart' as _i509;
import 'package:injectable/injectable.dart' as _i526;

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
    gh.lazySingleton<_i11.AuthRemoteDataSource>(
        () => _i966.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i247.AuthRepository>(
        () => _i773.AuthRepositoryImpl(gh<_i11.AuthRemoteDataSource>()));
    gh.factory<_i341.SignInWithGoogleUseCase>(
        () => _i341.SignInWithGoogleUseCase(gh<_i247.AuthRepository>()));
    gh.factory<_i509.SignOutUseCase>(
        () => _i509.SignOutUseCase(gh<_i247.AuthRepository>()));
    return this;
  }
}
