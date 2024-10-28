import 'dart:io';

import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/core/alert/alert_manager_impl.dart';
import 'package:balcony/core/api/api_module.dart';
import 'package:balcony/core/assets/asset_manager.dart';
import 'package:balcony/core/session/app_session.dart';
import 'package:balcony/core/session/session.dart';
import 'package:balcony/data/repository/user_repository.dart';
import 'package:balcony/data/repository_impl/user_repository_impl.dart';
import 'package:balcony/router/app_router.dart';
import 'package:balcony/values/colors.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// setup hive
  final appDocumentDir = Platform.isAndroid
      ? await getApplicationDocumentsDirectory()
      : await getLibraryDirectory();

  Hive.init(appDocumentDir.path);

  /*// Register the adapter only if it's not registered yet
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserDataAdapter());
  }*/
  await ApiModule().provides();
  locator.registerSingletonAsync<Session>(() => AppSession.getInstance());
  locator.registerSingleton(AppRouter());
  locator.registerSingleton(AppColor());
  locator.registerSingleton(AssetManager());
  locator.registerLazySingleton<AlertManager>(() => AlertManagerImpl());
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(locator()));
  locator.registerLazySingleton<Logger>(() => Logger(level: Level.all));

  /// setup API modules with repos which requires [Dio] instance
}

final logger = locator<Logger>();
