import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra/util/constants/general.dart';
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
      // appBar: AppBar(
      //   leading: DrawerWidgetMenu(
      //     onClicked: widget.openDrawer,
      //   ),
      //   backgroundColor: Colors.transparent,
      //   title: Text("Dashboard"),
      // ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        margin: EdgeInsets.only(left: 200),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.teal,
                                Colors.tealAccent,
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(right: 270),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.teal,
                                Colors.tealAccent,
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.circular(100)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
