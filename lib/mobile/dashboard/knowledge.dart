import 'package:flutter/material.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_menu.dart';

class Knowledge extends StatelessWidget {
  final VoidCallback openDrawer;

  const Knowledge({
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
        title: Text("Knowledge"),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
