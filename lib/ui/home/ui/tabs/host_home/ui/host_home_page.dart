import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HostHomePage extends StatefulWidget {
  const HostHomePage({super.key});

  @override
  State<HostHomePage> createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
