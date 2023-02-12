import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra/util/prefs/user.dart';
import 'package:sutra/util/prefs/user_preferences.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_menu.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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

  static const _backgroundColor = Color(0xFFF15BB5);

  static const _colors = [
    Color(0xFFFEE440),
    Color(0xFF00BBF9),
  ];

  static const _durations = [
    5000,
    4000,
  ];

  static const _heightPercentages = [
    0.65,
    0.66,
  ];

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
        title: Text("Dashboard"),
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              height: 100.0,
              child: Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.yellow,
                child: const Text(
                  'Shimmer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // WaveWidget(
            //   config: CustomConfig(
            //     colors: _colors,
            //     durations: _durations,
            //     heightPercentages: _heightPercentages,
            //   ),
            //   backgroundColor: _backgroundColor,
            //   size: Size(double.infinity, double.infinity),
            //   waveAmplitude: 0,
            // ),
          ],
        ),
      ),
    );
  }
}
