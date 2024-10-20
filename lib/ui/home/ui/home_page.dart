import 'package:auto_route/annotations.dart';
import 'package:balcony/ui/home/ui/tabs/user_and_host/ui/user_and_host_page.dart';
import 'package:balcony/ui/home/ui/tabs/workspace_and_property/ui/workspace_and_property_page.dart';
import 'package:balcony/ui/home/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';

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
      "works": WorkspaceAndPropertyPage(
        isWorkSpace: true,
        key: UniqueKey(),
      ),
      "stays": WorkspaceAndPropertyPage(
        isWorkSpace: false,
        key: UniqueKey(),
      ),
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
              : UserAndHostPage(
                  isUserSelected: selectedTab == 'user',
                  onItemSelected: (s) {
                    setState(() {
                      selectedTab = s;
                    });
                  },
                ),
        ),
        BottomNavigation(
          onItemSelected: (s) {
            setState(() {
              selectedTab = s;
            });
          },
        ),
      ],
    ));
  }
}
