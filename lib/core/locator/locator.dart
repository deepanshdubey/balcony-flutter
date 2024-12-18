import 'dart:io';

import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/alert/alert_manager_impl.dart';
import 'package:homework/core/api/api_module.dart';
import 'package:homework/core/assets/asset_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/core/session/session.dart';
import 'package:homework/data/model/response/user_data.dart';
import 'package:homework/data/repository/booking_repository.dart';
import 'package:homework/data/repository/chat_repository.dart';
import 'package:homework/data/repository/promo_repository.dart';
import 'package:homework/data/repository/property_repository.dart';
import 'package:homework/data/repository/tenant_repository.dart';
import 'package:homework/data/repository/user_repository.dart';
import 'package:homework/data/repository/wallet_repository.dart';
import 'package:homework/data/repository/workspace_repository.dart';
import 'package:homework/data/repository_impl/booking_repository_impl.dart';
import 'package:homework/data/repository_impl/chat_repository_impl.dart';
import 'package:homework/data/repository_impl/promo_repository_impl.dart';
import 'package:homework/data/repository_impl/property_repository_impl.dart';
import 'package:homework/data/repository_impl/tenant_repository_impl.dart';
import 'package:homework/data/repository_impl/user_repository_impl.dart';
import 'package:homework/data/repository_impl/wallet_repository_impl.dart';
import 'package:homework/data/repository_impl/workspace_repository_impl.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/store/support_ticket_store.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/store/wallet_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/store/address_store.dart';
import 'package:homework/values/colors.dart';
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

  // Register the adapter only if it's not registered yet
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserDataAdapter());
  }
  await ApiModule().provides();
  locator.registerSingletonAsync<Session>(() => AppSession.getInstance());
  locator.registerSingleton(AppRouter());
  locator.registerSingleton(AppColor());
  locator.registerSingleton(AssetManager());
  locator.registerLazySingleton<AlertManager>(() => AlertManagerImpl());
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(locator()));
  locator.registerLazySingleton<WorkspaceRepository>(
      () => WorkspaceRepositoryImpl(locator()));
  locator.registerLazySingleton<PropertyRepository>(
      () => PropertyRepositoryImpl(locator()));
  locator.registerLazySingleton<PromoRepository>(
      () => PromoRepositoryImpl(locator()));
  locator.registerLazySingleton<WalletRepository>(
      () => WalletRepositoryImpl(locator()));
  locator.registerLazySingleton<BookingRepository>(
      () => BookingRepositoryImpl(locator()));
  locator.registerLazySingleton<TenantRepository>(
      () => TenantRepositoryImpl(locator()));
  locator.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(locator()));
  locator.registerLazySingleton<Logger>(() => Logger(level: Level.all));
  locator.registerLazySingleton<AddressStore>(() => AddressStore());
  locator.registerLazySingleton<SupportTicketStore>(() => SupportTicketStore());
  locator.registerLazySingleton<WalletStore>(() => WalletStore());

  /// setup API modules with repos which requires [Dio] instance
}

final logger = locator<Logger>();
