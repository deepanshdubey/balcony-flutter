import 'package:auto_route/annotations.dart';
import 'package:balcony/core/session/app_session.dart';
import 'package:balcony/ui/auth/ui/bottomsheet/onboarding_bottomsheet.dart';
import 'package:balcony/ui/home/ui/tabs/chat/ui/chat_page.dart';
import 'package:balcony/ui/home/ui/tabs/host_home/ui/host_home_page.dart';
import 'package:balcony/ui/home/ui/tabs/more/ui/more_page.dart';
import 'package:balcony/ui/home/ui/tabs/search/search_page.dart';
import 'package:balcony/ui/home/ui/tabs/stay/ranted_history_page.dart';
import 'package:balcony/ui/home/ui/tabs/user_home/ui/user_home_page.dart';
import 'package:balcony/ui/home/ui/tabs/works/booking_history_page.dart';
import 'package:balcony/ui/home/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    bottomPages = {
      "search": const Center(child: Text("Search")),
      "chat": const Center(child: Text("Chat")),
      "works": const WorkspacePage(),
      "stays": const PropertyPage(),
      "more": const Center(child: Text("More")),
    };
    super.initState();
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
                  : const HostHomePage(),
        ),
        BottomNavigation(
          onItemSelected: handleNavigation,
        ),
      ],
    ));
  }

  void handleNavigation(String s) {
    print("click tab --> $s");
    if (s == "chat") {
      showChatBottomSheet(context);
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
      showAppBottomSheet(context, BookingHistoryPage());
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
