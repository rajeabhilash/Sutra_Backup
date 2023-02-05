import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sutra/mobile/landing/landed.dart';
import 'package:sutra/mobile/landing/verify_email.dart';

class MobileSplash extends StatefulWidget {
  const MobileSplash({super.key});

  @override
  State<MobileSplash> createState() => _MobileSplashState();
}

final indexPageKey = GlobalKey<NavigatorState>();

class _MobileSplashState extends State<MobileSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: indexPageKey,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong.!'),
            );
          } else if (snapshot.hasData) {
            return const VerifyEmail();
          } else {
            return const LandingPage();
          }
        },
      ),
    );
  }
}
