import 'package:auto_route/annotations.dart';
import 'package:balcony/ui/home/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        onItemSelected: (_) {},
      ),
    );
  }
}
