import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_menu.dart';

class Insights extends StatelessWidget {
  final VoidCallback openDrawer;

  const Insights({
    super.key,
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer();
    AudioCache audioCache = AudioCache(prefix: 'assets');

    return Scaffold(
      appBar: AppBar(
        leading: DrawerWidgetMenu(
          onClicked: openDrawer,
        ),
        backgroundColor: Colors.transparent,
        title: Text("Insights"),
      ),
      body: Center(
        child: Text("Insights"),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
