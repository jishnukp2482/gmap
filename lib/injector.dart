import 'package:get_it/get_it.dart';
import 'package:gmap/core/connection_checker.dart';
import 'package:gmap/data/remote/data_source/appdata_source.dart';
import 'package:gmap/data/repository/app_repository.dart';
import 'package:gmap/domain/repositories/app_repositoryimpl.dart';
import 'package:gmap/domain/usecase/formUsecase.dart';
import 'package:gmap/domain/usecase/getRote_UseCase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/api_provider.dart';

final sl = GetIt.instance;
Future<void> setUp() async {
  //core
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(sl()));
  sl.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(sl()));
  sl.registerLazySingleton<AppDataSource>(() => AppDataSourceImpl(sl()));
  sl.registerLazySingleton<GetRouteUseCase>(() => GetRouteUseCase(sl()));
  sl.registerLazySingleton<FormUsecase>(() => FormUsecase(sl()));
}
