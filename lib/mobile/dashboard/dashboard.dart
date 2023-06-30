import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_heatmap_calendar/simple_heatmap_calendar.dart';
import 'package:sutra/util/constants/general.dart';
import 'package:sutra/util/prefs/user.dart';
import 'package:sutra/util/prefs/user_preferences.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_menu.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addSpacer(8.0),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Good Morning,",
                          style: TextStyle(
                            fontFamily: 'Exo',
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          width: 234,
                          child: Text(
                            "Raje Abhilash Mohite".toUpperCase(),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontFamily: 'Exo',
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 74,
                      child: Image.asset('asset/Brand/Black_Wire.png'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Card(
                  elevation: 2,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 100,
                            width: 246,
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(11),
                              color: Colors.white,
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 74,
                                    child: Image.asset(
                                        'asset/images/Levels/1.png'),
                                  ),
                                  addHSpacer(26.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      Text(
                                        "BODY",
                                        style: TextStyle(
                                          fontFamily: 'Exo',
                                          fontSize: 32,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        "Difficulty - Medium",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontFamily: 'Exo',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "21",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Exo',
                                    fontSize: 50,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  "Days of Streak",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Exo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Card(
                  elevation: 2,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    // child: Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: SingleChildScrollView(
                    //     physics: const PageScrollPhysics(),
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.max,
                    //       children: [],
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Card(
                  elevation: 2,
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1.0)),
                    // child: Center(
                    //   child: HeatmapCalendar<num>(
                    //     startDate: DateTime(2020, 1, 1),
                    //     endedDate: DateTime(2025, 12, 31),
                    //     colorMap: {
                    //       10: theme.primaryColor.withOpacity(0.2),
                    //       20: theme.primaryColor.withOpacity(0.4),
                    //       30: theme.primaryColor.withOpacity(0.6),
                    //       40: theme.primaryColor.withOpacity(0.8),
                    //       50: theme.primaryColor,
                    //     },
                    //     selectedMap: {
                    //       DateTime(2025, 12, 31): 10,
                    //       DateTime(2025, 12, 30): 20,
                    //       DateTime(2025, 12, 29): 30,
                    //       DateTime(2025, 12, 28): 40,
                    //       DateTime(2025, 12, 26): 50,
                    //       DateTime(2025, 12, 22): 60,
                    //       DateTime(2025, 12, 12): 999,
                    //       DateTime(2025, 12, 1): 0,
                    //       DateTime(2025, 11, 23): 12,
                    //       DateTime(2025, 12, 16): 34,
                    //       DateTime(2025, 12, 15): 45,
                    //       DateTime(2025, 12, 12): 89,
                    //       DateTime(2020, 1, 16): 34,
                    //       DateTime(2020, 1, 15): 45,
                    //       DateTime(2020, 1, 12): 89,
                    //     },
                    //     cellSize: const Size.square(16.0),
                    //     colorTipCellSize: const Size.square(12.0),
                    //     style: const HeatmapCalendarStyle.defaults(
                    //       cellValueFontSize: 6.0,
                    //       cellRadius: BorderRadius.all(Radius.circular(4.0)),
                    //       weekLabelValueFontSize: 12.0,
                    //       monthLabelFontSize: 12.0,
                    //     ),
                    //     layoutParameters:
                    //         const HeatmapLayoutParameters.defaults(
                    //       monthLabelPosition: CalendarMonthLabelPosition.top,
                    //       weekLabelPosition: CalendarWeekLabelPosition.right,
                    //       colorTipPosition: CalendarColorTipPosition.bottom,
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 64,
        elevation: 5,
        color: Colors.transparent,
        padding: EdgeInsets.all(0),
        surfaceTintColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 4, 14, 4),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 64,
                child: Image.asset('asset/DarkSutra.png'),
              ),
              InkWell(
                onTap: () {
                  print("Agenda Started");
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        "  Start  ",
                        style: TextStyle(
                          fontFamily: 'Exo',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
