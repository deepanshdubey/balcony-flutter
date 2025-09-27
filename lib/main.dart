import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/core/session/session.dart';
import 'package:homework/core/socket/socket_provider.dart';
import 'package:homework/cubit/internet_cubit.dart';
import 'package:homework/data/repository_impl/socket_chat_manager.dart';
import 'package:homework/l10n/l10n.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/values/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      try {
        WidgetsFlutterBinding.ensureInitialized();
        await setupLocator();
        await locator.isReady<Session>();
        socketManager.connect(token: session.token, isAnonymous: false);
      } catch (error, st) {
        logger.e(error);
        logger.e(st);
      }

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then(
        (value) => runApp(
          ChangeNotifierProvider(
            create: (_) => SocketProvider()..initializeSocket(),
            child: BlocProvider(
              create: (_) => InternetCubit(), // Provide the InternetCubit
              child: MyApp(appRouter: locator<AppRouter>()),
            ),
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

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({required this.appRouter, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (context, child) => MaterialApp.router(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          child = ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: child!,
          );
          return BlocListener<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state == InternetState.lost) {
                debugPrint("Internet Lost");
                ScaffoldMessenger.of(context).showMaterialBanner(
                  const MaterialBanner(
                    backgroundColor: Colors.red,
                    content: Text(
                      "No Internet Connection",
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [],
                  ),
                );
              } else if (state == InternetState.gain) {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              }
            },
            child: child,
          );
        },
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        onGenerateTitle: (context) =>
            S.of(context)?.applicationTitle ?? 'homework',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.supportedLocales,
      ),
    );
  }
}
