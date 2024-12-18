import 'dart:async';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/core/session/session.dart';
import 'package:homework/core/socket/socket_provider.dart';
import 'package:homework/generated/l10n.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/values/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maptiler_flutter/maptiler_flutter.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  runZonedGuarded(
        () async {
      try {
        WidgetsFlutterBinding.ensureInitialized();
        await setupLocator();
        await locator.isReady<Session>();
        MapTilerConfig.setApiKey('Np0YtMXcGscEPnJKgTsu');
      } catch (error, st) {
        logger.e(error);
        logger.e(st);
      }

      /// Disable debugPrint logs in production
      if (kReleaseMode) {
        debugPrint = (String? message, {int? wrapWidth}) {};
      }

      // Fixing App Orientation.
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then(
            (value) => runApp(
          ChangeNotifierProvider(
            create: (_) => SocketProvider()..initializeSocket(),
            child: MyApp(appRouter: locator<AppRouter>()),
          ),
        ),
      );
    },
        (error, stack) => (Object error, StackTrace stackTrace) {
      if (!kReleaseMode) {
        debugPrint('[Error]: $error');
        debugPrint('[Stacktrace]: $stackTrace');
      }
    },
  );
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({required this.appRouter, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (context, child) => MaterialApp.router(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, child) {
          child = ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: child!,
          );
          child = MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0), boldText: false),
            child: child,
          );
          return child;
        },
        routerDelegate: widget.appRouter.delegate(),
        routeInformationParser: widget.appRouter.defaultRouteParser(),
        onGenerateTitle: (context) => S.of(context).applicationTitle,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}

void handleNavigation(Map<String, dynamic> data) {
  logger.i("Notification clicked");
  logger.i(data);
}
