import 'package:auto_route/annotations.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/ui/auth/ui/bottomsheet/onboarding_bottomsheet.dart';
import 'package:homework/ui/auth/ui/sign_in_page.dart';
import 'package:homework/ui/home/ui/tabs/chat/ui/chat_page.dart';
import 'package:homework/ui/home/ui/tabs/host_home/ui/host_home_page.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/more_page.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/create_workspace/ui/create_workspace_page.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/store/dashboard_store.dart';
import 'package:homework/ui/home/ui/tabs/search/search_page.dart';
import 'package:homework/ui/home/ui/tabs/stay/ranted_history_page.dart';
import 'package:homework/ui/home/ui/tabs/user_home/ui/user_home_page.dart';
import 'package:homework/ui/home/ui/tabs/works/booking_history_page.dart';
import 'package:homework/ui/home/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:homework/ui/home/widget/logout_alert.dart';
import 'package:mobx/mobx.dart';
import 'tabs/property_and_workspace/property/ui/property_page.dart';
import 'tabs/property_and_workspace/workspace/ui/workspace_page.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<String, Widget> bottomPages;
  late Widget homePage;
  String selectedTab = 'user';
  var store = DashboardStore();
  List<ReactionDisposer>? disposers;
  final dashboardStore = DashboardStore();

  @override
  void initState() {
    store.getReAuthenticate();
    bottomPages = {
      "search": const Center(child: Text("Search")),
      "chat": const Center(child: Text("Chat")),
      "works": const WorkspacePage(),
      "stays": const PropertyPage(),
      "more": const Center(child: Text("More")),
    };
    addDisposer();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => store.reAuthenticateResponse, (response) {
        if (response?.success == false) {
          session.isLogin = false;
          showLogoutAlert(context);
        }
      }),
    ];
  }

  void showLogoutAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return LogoutAlertWidget(
          onLoginPressed: () {
            Navigator.of(dialogContext).pop();
            showAppBottomSheet(
              context,
              SignInPage(
                onSuccess: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              ),
            );
          },
          onCancelPressed: () {
            Navigator.of(dialogContext).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          child: bottomPages.containsKey(selectedTab)
              ? bottomPages[selectedTab]
              : selectedTab == 'user'
                  ? const UserHomePage()
                  : HostHomePage()

        ),
        BottomNavigation(
          onItemSelected: handleNavigation,
        ),
      ],
    ));
  }

  void handleNavigation(String s) {
    if (s == "chat") {
      if (session.isLogin) {
        showChatBottomSheet(context);
      } else {
        showOnboardingBottomSheet(
          context,
          onSuccess: () => showChatBottomSheet(context),
        );
      }
    } else if (s == "more") {
      if (session.isLogin) {
        showAppBottomSheet(context, const MorePage());
      } else {
        showOnboardingBottomSheet(
          context,
          onSuccess: () => showAppBottomSheet(context, const MorePage()),
        );
      }
    } else if (s == "works") {
      if (session.isLogin) {
        showAppBottomSheet(context, BookingHistoryPage());
      } else {
        showOnboardingBottomSheet(
          context,
          onSuccess: () => showAppBottomSheet(context, BookingHistoryPage()),
        );
      }
    } else if (s == "stays") {
      showAppBottomSheet(context, RantedHistoryPage());
    } else if (s == "search") {
      showAppBottomSheet(context, const SearchPage());
    } else {
      setState(() {
        selectedTab = s;
      });
    }
  }
}
