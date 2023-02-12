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
        padding: const EdgeInsets.fromLTRB(2, 32, 2, 0),
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
                    fontSize: 24,
                  ),
                ),
                subtitle: const Text(
                  "Level : Body",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              addSpacer(24.0),
              const Divider(
                color: Colors.white54,
                endIndent: 26,
                indent: 26,
                thickness: 0.5,
              ),
              addSpacer(24.0),
              buildDrawerItems(context),
              addSpacer(24.0),
              const Divider(
                color: Colors.white54,
                endIndent: 26,
                indent: 26,
                thickness: 0.5,
              ),
              addSpacer(24.0),
              SizedBox(
                width: 100,
                child: Opacity(
                  opacity: 0.75,
                  child: Shimmer.fromColors(
                      child: Image.asset('asset/Brand/White_Wire.png'),
                      baseColor: Colors.teal,
                      highlightColor: Colors.white),
                ),
              ),
              addSpacer(12.0),
              SizedBox(
                width: 64,
                child: Opacity(
                  opacity: 0.75,
                  child: Shimmer.fromColors(
                      child: Image.asset('asset/LightSutra.png'),
                      baseColor: Colors.teal,
                      highlightColor: Colors.white),
                ),
              ),
              addSpacer(12.0),
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
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.teal.shade800,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(14))),
                          ),
                        )
                      : SizedBox(),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 2.0),
                    leading: Icon(
                      item.icon,
                      color: Colors.white,
                    ),
                    // selected: true,
                    // selectedTileColor: Colors.teal.shade800,
                    title: Text(
                      item.title,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
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
