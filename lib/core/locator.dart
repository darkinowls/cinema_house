import 'package:cinema_house/core/dio_client.dart';
import 'package:cinema_house/features/auth/cubit/auth_cubit.dart';
import 'package:cinema_house/features/auth/data/auth_api.dart';
import 'package:cinema_house/features/auth/repositories/auth_repository.dart';
import 'package:cinema_house/features/lightMode/repository/light_mode_repository.dart';
import 'package:cinema_house/features/network/cubit/network_cubit.dart';
import 'package:cinema_house/features/tickets/domain/entities/ticket_entity.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../features/comments/data/comments_api.dart';
import '../features/comments/data/repositories/i_comments_repository.dart';
import '../features/comments/domain/repositories/comments_repository.dart';
import '../features/lang/repositories/lang_repository.dart';
import '../features/lightMode/cubit/light_mode_cubit.dart';
import '../features/movies/data/movies_api.dart';
import '../features/movies/repositories/movies_repository.dart';
import '../features/sessions/data/sessions_api.dart';
import '../features/sessions/domain/repositories/sessions_repository.dart';
import '../features/tickets/data/tickets_api.dart';
import '../features/tickets/domain/repositories/tickets_repository.dart';
import '../features/user/data/user_api.dart';
import '../features/user/domain/user_repository.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  await _setupAtAppStart();

  locator.registerLazySingleton<TicketsApi>(
      () => TicketsApi(locator<DioClient>()));

  Hive.registerAdapter<TicketEntity>(TicketEntityAdapter());

  Box<TicketEntity> ticketBox = await Hive.openBox<TicketEntity>("tickets");

  locator.registerLazySingleton<TicketsRepository>(
      () => TicketsRepository(ticketBox, locator<TicketsApi>()));

  locator
      .registerLazySingleton<MoviesApi>(() => MoviesApi(locator<DioClient>()));

  locator.registerLazySingleton<MoviesRepository>(
      () => MoviesRepository(locator<MoviesApi>()));

  locator.registerLazySingleton<CommentsApi>(
      () => CommentsApi(locator<DioClient>()));

  locator.registerLazySingleton<ICommentsRepository>(
      () => CommentsRepository(locator<CommentsApi>()));

  locator.registerLazySingleton<UserApi>(() => UserApi(locator<DioClient>()));

  locator.registerLazySingleton<UserRepository>(
      () => UserRepository(locator<UserApi>()));

  locator.registerLazySingleton<SessionsApi>(
      () => SessionsApi(locator<DioClient>()));

  locator.registerLazySingleton<SessionsRepository>(
      () => SessionsRepository(locator<SessionsApi>()));
}

// ---------------------------------------------------------------------
// ---------------------------------------------------------------------
// ---------------------------------------------------------------------

Future<void> _setupAtAppStart() async {
  locator.registerSingleton<NetworkCubit>(NetworkCubit());
  await locator<NetworkCubit>().updateStatus();

  await Hive.initFlutter();
  Box<bool> lightModeBox = await Hive.openBox<bool>("lightMode");

  locator.registerSingleton<LightModeRepository>(
      LightModeRepository(lightModeBox));

  locator.registerSingleton<LightModeCubit>(
      LightModeCubit(locator<LightModeRepository>()));

  locator.registerSingleton<DioClient>(DioClient());
  locator.registerSingleton<AuthApi>(AuthApi(locator<DioClient>()));
  Box<String> tokenBox = await Hive.openBox<String>("accessToken");
  locator.registerSingleton<AuthRepository>(
      AuthRepository(tokenBox, locator<AuthApi>()));

  locator.registerSingleton<AuthCubit>(AuthCubit(locator<AuthRepository>()));

  // locator
  //     .registerSingleton<LangRepository>(LangRepository(locator<DioClient>()));
}
