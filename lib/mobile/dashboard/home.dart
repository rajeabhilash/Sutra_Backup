import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sutra/mobile/dashboard/dashboard.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_item.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_item_list.dart';
import 'package:sutra/mobile/dashboard/drawer/hidden_drawer.dart';
import 'package:sutra/mobile/dashboard/explore.dart';
import 'package:sutra/mobile/dashboard/favorites.dart';
import 'package:sutra/mobile/dashboard/insights.dart';
import 'package:sutra/mobile/dashboard/knowledge.dart';
import 'package:sutra/mobile/dashboard/settings.dart';
import 'package:sutra/util/prefs/user_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double xOffset;
  late double yOffset;
  late double zRotate;
  late double scaleFactor;

  late bool isDrawerOpen;
  bool isDragging = false;

  DrawerItem item = DrawerItems.home;
  int drawerIndex = 0;
  bool isActive = false;

  @override
  void initState() {
    super.initState();

    // openDrawer();
    closeDrawer();
  }

  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        zRotate = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });

  void openDrawer() => setState(() {
        xOffset = 230;
        yOffset = 130;
        zRotate = 0;
        scaleFactor = 0.65;
        isDrawerOpen = true;
      });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [
            buildDrawer(),
            buildPage(),
          ],
        ),
      );

  Widget buildDrawer() => SafeArea(
        child: Container(
          width: xOffset,
          child: HiddenDrawers(
            currentIndex: drawerIndex,
            onSelectedItem: (item) {
              switch (item) {
                case DrawerItems.logout:
                  UserPreferences.clearUserData();
                  FirebaseAuth.instance.signOut();
                  break;
                default:
                  setState(() {
                    this.item = item;
                    drawerIndex = DrawerItems.all.indexOf(item);
                  });
                  closeDrawer();
              }
            },
          ),
        ),
      );

  Widget buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return false;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDragging) return;
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
          isDragging = false;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..rotateX(zRotate)
            ..scale(scaleFactor),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(isDrawerOpen ? 24.0 : 0.0)),
              child: Container(
                color: isDrawerOpen ? Colors.white60 : Colors.white,
                child: getDrawerPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawerPage() {
    switch (item) {
      case DrawerItems.home:
        return DashBoard(openDrawer: openDrawer);
      case DrawerItems.insights:
        return Insights(openDrawer: openDrawer);
      case DrawerItems.explore:
        return Explore(openDrawer: openDrawer);
      case DrawerItems.favorites:
        return Favorites(openDrawer: openDrawer);
      case DrawerItems.knowledge:
        return Knowledge(openDrawer: openDrawer);
      case DrawerItems.settings:
        return Settings(openDrawer: openDrawer);
      default:
        return DashBoard(openDrawer: openDrawer);
    }
  }
}
