import 'dart:async';

import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/core/session/session.dart';
import 'package:balcony/generated/l10n.dart';
import 'package:balcony/router/app_router.dart';
import 'package:balcony/values/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      try {
        WidgetsFlutterBinding.ensureInitialized();

        await setupLocator();
        await locator.isReady<Session>();
      } catch (error, st) {
        logger.e(error);
        logger.e(st);
      }

      /// Disable debugPrint logs in production
      if (kReleaseMode) {
        debugPrint = (String? message, {int? wrapWidth}) {};
      }

      // initialize firebase app
      //await Firebase.initializeApp();

      // Fixing App Orientation.
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then(
        (value) => runApp(MyApp(appRouter: locator<AppRouter>())),
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
            child: child,
            data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0), boldText: false),
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
