import 'package:auto_route/auto_route.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page),
  ];

}

final appRouter = locator<AppRouter>();
