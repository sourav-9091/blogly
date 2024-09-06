import 'package:blog_firebase/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_firebase/core/secrets/app_secrets.dart';
import 'package:blog_firebase/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_firebase/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_firebase/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_firebase/features/auth/domain/repository/usecases/current_user.dart';
import 'package:blog_firebase/features/auth/domain/repository/usecases/user_sign_in.dart';
import 'package:blog_firebase/features/auth/domain/repository/usecases/user_sign_up.dart';
import 'package:blog_firebase/features/auth/presentation/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnon,
  );
  serviceLocator.registerLazySingleton<SupabaseClient>(
    () => supabase.client,
  );

  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator<SupabaseClient>(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator<AuthRemoteDataSource>(),
    ),
  );
  serviceLocator.registerFactory<UserSignUp>(
    () => UserSignUp(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory<UserSignIn>(
    () => UserSignIn(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory<CurrentUser>(
    () => CurrentUser(
      authRepository: serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignup: serviceLocator<UserSignUp>(),
      userSignIn: serviceLocator<UserSignIn>(),
      currentUser: serviceLocator<CurrentUser>(),
      appUserCubit: serviceLocator<AppUserCubit>(),
    ),
  );
}
