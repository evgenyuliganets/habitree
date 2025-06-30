// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:habitree/core/network/dio_client.dart' as _i249;
import 'package:habitree/core/network/dio_module.dart' as _i1011;
import 'package:habitree/data/data_sources/auth/local/auth_local_datasource.dart'
    as _i174;
import 'package:habitree/data/data_sources/auth/local/secure_auth_local_datasource.dart'
    as _i197;
import 'package:habitree/data/data_sources/auth/remote/auth_remote_datasource.dart'
    as _i11;
import 'package:habitree/data/data_sources/auth/remote/auth_remote_datasource_impl.dart'
    as _i966;
import 'package:habitree/data/data_sources/habits/remote/habits_remote_datasource.dart'
    as _i349;
import 'package:habitree/data/data_sources/habits/remote/habits_remote_datasource_impl.dart'
    as _i232;
import 'package:habitree/data/services/auth/google_sign_in_service.dart'
    as _i205;
import 'package:habitree/di/database_module.dart' as _i1050;
import 'package:habitree/domain/repositories/auth/auth_repository.dart'
    as _i247;
import 'package:habitree/domain/repositories/auth/auth_repository_impl.dart'
    as _i773;
import 'package:habitree/domain/repositories/habits/habits_repository.dart'
    as _i892;
import 'package:habitree/domain/repositories/habits/habits_repository_impl.dart'
    as _i409;
import 'package:habitree/domain/usecases/auth/check_email_status.dart' as _i345;
import 'package:habitree/domain/usecases/auth/confirm_otp_usecase.dart'
    as _i203;
import 'package:habitree/domain/usecases/auth/delete_account_usecase.dart'
    as _i506;
import 'package:habitree/domain/usecases/auth/get_current_session_usecase.dart'
    as _i1001;
import 'package:habitree/domain/usecases/auth/send_otp_email.dart' as _i490;
import 'package:habitree/domain/usecases/auth/sign_in_with_google_usecase.dart'
    as _i341;
import 'package:habitree/domain/usecases/auth/sign_out_usecase.dart' as _i509;
import 'package:habitree/domain/usecases/habits/get_habits_status_usecase.dart'
    as _i630;
import 'package:habitree/presentation/auth/providers/auth_notifier.dart'
    as _i494;
import 'package:habitree/presentation/home/habits_ui/provider/habits_by_date_notifier.dart'
    as _i1043;
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
    final databaseModule = _$DatabaseModule();
    final dioModule = _$DioModule();
    gh.lazySingleton<_i205.GoogleSignInService>(
        () => _i205.GoogleSignInService());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => databaseModule.secureStorage);
    gh.factory<_i174.AuthLocalDataSource>(() =>
        _i197.SecureAuthLocalDataSource(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.dio(gh<_i174.AuthLocalDataSource>()));
    gh.lazySingleton<_i249.DioClient>(
        () => dioModule.dioClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i11.AuthRemoteDataSource>(
        () => _i966.AuthRemoteDataSourceImpl(
              gh<_i249.DioClient>(),
              gh<_i174.AuthLocalDataSource>(),
            ));
    gh.factory<_i247.AuthRepository>(() => _i773.AuthRepositoryImpl(
          gh<_i11.AuthRemoteDataSource>(),
          gh<_i174.AuthLocalDataSource>(),
        ));
    gh.factory<_i349.HabitsRemoteDataSource>(
        () => _i232.HabitsRemoteDataSourceImpl(gh<_i249.DioClient>()));
    gh.factory<_i341.SignInWithGoogleUseCase>(
        () => _i341.SignInWithGoogleUseCase(
              gh<_i205.GoogleSignInService>(),
              gh<_i247.AuthRepository>(),
            ));
    gh.factory<_i345.CheckEmailStatusUseCase>(
        () => _i345.CheckEmailStatusUseCase(gh<_i247.AuthRepository>()));
    gh.factory<_i509.SignOutUseCase>(() => _i509.SignOutUseCase(
          gh<_i247.AuthRepository>(),
          gh<_i205.GoogleSignInService>(),
        ));
    gh.factory<_i203.ConfirmOtpEmailUseCase>(
        () => _i203.ConfirmOtpEmailUseCase(gh<_i247.AuthRepository>()));
    gh.factory<_i506.DeleteAccountUseCase>(
        () => _i506.DeleteAccountUseCase(gh<_i247.AuthRepository>()));
    gh.factory<_i1001.GetCurrentSessionUseCase>(
        () => _i1001.GetCurrentSessionUseCase(gh<_i247.AuthRepository>()));
    gh.factory<_i490.SendOtpEmailUseCase>(
        () => _i490.SendOtpEmailUseCase(gh<_i247.AuthRepository>()));
    gh.factory<_i892.HabitsRepository>(
        () => _i409.HabitRepositoryImpl(gh<_i349.HabitsRemoteDataSource>()));
    gh.factory<_i494.AuthNotifier>(() => _i494.AuthNotifier(
          gh<_i341.SignInWithGoogleUseCase>(),
          gh<_i509.SignOutUseCase>(),
          gh<_i506.DeleteAccountUseCase>(),
          gh<_i1001.GetCurrentSessionUseCase>(),
          gh<_i490.SendOtpEmailUseCase>(),
          gh<_i203.ConfirmOtpEmailUseCase>(),
        ));
    gh.factory<_i630.GetUserHabitsByDateUseCase>(
        () => _i630.GetUserHabitsByDateUseCase(gh<_i892.HabitsRepository>()));
    gh.factory<_i1043.HabitsByDateNotifier>(() =>
        _i1043.HabitsByDateNotifier(gh<_i630.GetUserHabitsByDateUseCase>()));
    return this;
  }
}

class _$DatabaseModule extends _i1050.DatabaseModule {}

class _$DioModule extends _i1011.DioModule {}
