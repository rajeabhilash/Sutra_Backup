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
    return Scaffold(
      appBar: AppBar(
        leading: DrawerWidgetMenu(
          onClicked: openDrawer,
        ),
        backgroundColor: Colors.transparent,
        title: Text("Insights"),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
