import 'package:flutter/material.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_item_list.dart';
import 'package:sutra/util/constants/general.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_item.dart';

import 'package:shimmer/shimmer.dart';

class HiddenDrawers extends StatelessWidget {
  final ValueChanged<DrawerItem> onSelectedItem;
  late int currentIndex;

  HiddenDrawers(
      {super.key, required this.onSelectedItem, required this.currentIndex});

  @override
  Widget build(BuildContext context) => Container(
        // padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        padding: const EdgeInsets.fromLTRB(2, 16, 2, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              addSpacer(10.0),
              ListTile(
                leading: buildCircle(
                  all: 2,
                  color: Colors.white54,
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: Ink.image(
                        image: const NetworkImage('https://i.pravatar.cc/300'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        // image: FileImage(
                        //   File(
                        //       "/data/user/0/com.rajeabhilash.sutra/app_flutter/compressed_image_picker4474801720726160231.jpg"),
                        // ),
                      ),
                    ),
                  ),
                ),
                title: const Text(
                  "Raje Abhilash",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: const Text(
                  "Level : Body",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ),
              addSpacer(16.0),
              const Divider(
                color: Colors.white54,
                endIndent: 26,
                indent: 26,
                thickness: 0.5,
              ),
              addSpacer(16.0),
              buildDrawerItems(context),
              addSpacer(8.0),
              const Divider(
                color: Colors.white54,
                endIndent: 26,
                indent: 26,
                thickness: 0.5,
              ),
              addSpacer(36.0),
              SizedBox(
                width: 100,
                child: Opacity(
                  opacity: 0.56,
                  child: Image.asset('asset/Brand/White_Gradient.png'),
                ),
              ),
              addSpacer(8.0),
              SizedBox(
                width: 64,
                child: Opacity(
                  opacity: 0.56,
                  child: Image.asset('asset/LightSutra.png'),
                ),
              ),
              addSpacer(20.0),
              const Text(
                "App Version : v1.0.0",
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildDrawerItems(BuildContext context) => Column(
        children: DrawerItems.all
            .map(
              (item) => Stack(
                children: [
                  DrawerItems.all.indexOf(item) == currentIndex
                      ? AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          height: 54,
                          left: 10,
                          top: 4,
                          width: DrawerItems.all.indexOf(item) == currentIndex
                              ? 250
                              : 0,
                          child: Shimmer.fromColors(
                            highlightColor: Colors.teal,
                            baseColor: Colors.teal.shade800,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.teal.shade800,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14))),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 28.0,
                      vertical: 2.0,
                    ),
                    leading: Icon(
                      item.icon,
                      color: DrawerItems.all.indexOf(item) == currentIndex
                          ? Colors.white
                          : Colors.white54,
                    ),
                    // selected: true,
                    // selectedTileColor: Colors.teal.shade800,
                    title: Text(
                      item.title,
                      style: TextStyle(
                          color: DrawerItems.all.indexOf(item) == currentIndex
                              ? Colors.white
                              : Colors.white54,
                          fontSize:
                              DrawerItems.all.indexOf(item) == currentIndex
                                  ? 21
                                  : 18,
                          fontWeight:
                              DrawerItems.all.indexOf(item) == currentIndex
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                    ),
                    onTap: () {
                      onSelectedItem(item);
                    },
                  ),
                ],
              ),
            )
            .toList(),
      );
}
