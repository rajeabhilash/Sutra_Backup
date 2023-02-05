import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sutra/util/prefs/user.dart';
import 'package:sutra/util/prefs/user_preferences.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_menu.dart';

class DashBoard extends StatefulWidget {
  final VoidCallback openDrawer;

  const DashBoard({
    super.key,
    required this.openDrawer,
  });

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late UserData user;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DrawerWidgetMenu(
          onClicked: widget.openDrawer,
        ),
        backgroundColor: Colors.transparent,
        title: Text("Home"),
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
