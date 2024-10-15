import 'dart:io';

import 'package:balcony/core/assets/asset_manager.dart';
import 'package:balcony/core/session/app_session.dart';
import 'package:balcony/core/session/session.dart';
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
  locator.registerSingletonAsync<Session>(() => AppSession.getInstance());
  locator.registerSingleton(AppRouter());
  locator.registerSingleton(AppColor());
  locator.registerSingleton(AssetManager());

  locator.registerLazySingleton<Logger>(() => Logger(level: Level.all));
}

final logger = locator<Logger>();
