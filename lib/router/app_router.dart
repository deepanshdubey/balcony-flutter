import 'package:auto_route/auto_route.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/ui/auth/ui/start_page.dart';
import 'package:balcony/ui/home/ui/home_page.dart';
import 'package:balcony/ui/home/ui/tabs/host_home/ui/host_home_page.dart';
import 'package:balcony/ui/home/ui/tabs/plan/plan_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/ui/create_property/ui/create_property_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/ui/property_detail/property_details_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/ui/property_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/create_workspace/ui/create_workspace_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/search_property_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/search_workspace_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/workspace_details/workspace_detail_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/workspace_page.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/workspace_payment/workspace_payment_page.dart';
import 'package:balcony/ui/splash/splash_page.dart';
import 'package:balcony/ui/walkthrough/walkthrough_page.dart';
import 'package:flutter/material.dart';

import '../data/model/response/workspace_data.dart';


part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: WalkthroughRoute.page),
        AutoRoute(page: StartRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: WorkspaceDetailRoute.page),
        AutoRoute(page: WorkspacePaymentRoute.page),
        AutoRoute(page: WorkspaceDetailRoute.page),
        AutoRoute(page: PlansRoute.page),
        AutoRoute(page: PropertyDetailRoute.page),
        AutoRoute(page: CreateWorkspaceRoute.page),
        AutoRoute(page: CreateWorkspaceRoute.page),
        AutoRoute(page: CreatePropertyRoute.page),
        AutoRoute(page: WorkspaceRoute.page),
        AutoRoute(page: PropertyRoute.page),
        AutoRoute(page: SearchWorkspaceRoute.page),
        AutoRoute(page: SearchPropertyRoute.page),
      ];
}

final appRouter = locator<AppRouter>();
