import 'package:flutter/material.dart';
import 'package:sutra/tablet/landing/landed.dart';
import 'package:sutra/tablet/dashboard/home.dart';

class TabletSplash extends StatefulWidget {
  const TabletSplash({super.key});

  @override
  State<TabletSplash> createState() => _TabletSplashState();
}

class _TabletSplashState extends State<TabletSplash> {
  @override
  Widget build(BuildContext context) {
    return const LandingPage();
    // return const HomePage();
  }
}
