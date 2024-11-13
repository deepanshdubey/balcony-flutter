import 'package:auto_route/auto_route.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/ui/auth/ui/start_page.dart';
import 'package:balcony/ui/home/ui/home_page.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/workspace_details/workspace_detail_page.dart';
import 'package:balcony/ui/splash/splash_page.dart';
import 'package:balcony/ui/walkthrough/walkthrough_page.dart';

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
        AutoRoute(page: WorkspaceDetailRoute.page)
      ];
}

final appRouter = locator<AppRouter>();
