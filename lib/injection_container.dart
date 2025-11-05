import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/users/data/datasources/user_remote_data_source.dart';
import 'features/users/data/repositories/user_repository_impl.dart';
import 'features/users/domain/repositories/user_repo.dart';

import 'features/users/domain/usercases/get_users.dart';
import 'features/users/presentation/cubit/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit / Bloc
  sl.registerFactory(() => UserCubit(getUsersUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUsers(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(() =>
      UserRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}
