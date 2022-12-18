import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_udemy_course/core/platform/network_info.dart';
import 'package:new_udemy_course/features/data/datasources/person_local_datasource.dart';
import 'package:new_udemy_course/features/data/datasources/person_remote_datasource.dart';
import 'package:new_udemy_course/features/data/repositories/person_repository_impl.dart';
import 'package:new_udemy_course/features/domain/repository/person_repository.dart';
import 'package:new_udemy_course/features/domain/usecases/get_all_persons.dart';
import 'package:new_udemy_course/features/domain/usecases/search_persons.dart';
import 'package:new_udemy_course/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:new_udemy_course/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc/Cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllPersons(personRepository: sl()));
  sl.registerLazySingleton(() => SearchPerson(personRepository: sl()));

  // Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<PersonRemoteDataSource>(
      () => PersonRemoteDataSourceImplement(client: http.Client()));
  sl.registerLazySingleton<PersonLocalDataSource>(
      () => PersonLocalDataSourceImplement(sharedPreferences: sl()));

  // Core(Сеть)
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External(внешние зависимости)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
