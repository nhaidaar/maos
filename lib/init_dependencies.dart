import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/auth_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final GetIt serviceLocator = GetIt.I;

Future<void> initDependencies() async {
  await initAuth();
}

Future<void> initAuth() async {
  await dotenv.load(fileName: ".env");
  final supabase = await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_KEY'),
  );

  serviceLocator
    ..registerLazySingleton<SupabaseClient>(
      () => supabase.client,
    )
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(client: serviceLocator<SupabaseClient>()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator<AuthRemoteDatasource>()),
    )
    ..registerFactory<AuthUsecase>(
      () => AuthUsecase(serviceLocator<AuthRepository>()),
    )
    ..registerLazySingleton(
      () => AuthBloc(serviceLocator<AuthUsecase>()),
    );
}
