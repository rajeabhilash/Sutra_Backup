import 'package:flutter/material.dart';
import 'package:sutra/desktop/dashboard/home.dart';
import 'package:sutra/desktop/landing/landed.dart';

class DesktopSplash extends StatefulWidget {
  const DesktopSplash({super.key});

  @override
  State<DesktopSplash> createState() => _DesktopSplashState();
}

class _DesktopSplashState extends State<DesktopSplash> {
  @override
  Widget build(BuildContext context) {
    return const LandingPage();
    // return const HomePage();
  }
}
