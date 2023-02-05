import 'package:flutter/material.dart';
import 'package:sutra/util/constants/general.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_item.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_item_list.dart';
import 'package:sutra/mobile/dashboard/settings.dart';
import 'package:sutra/mobile/dashboard/dashboard.dart';

class HiddenDrawers extends StatelessWidget {
  final ValueChanged<DrawerItem> onSelectedItem;

  const HiddenDrawers({super.key, required this.onSelectedItem});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 120,
                child: Image.asset('asset/Brand/White_Wire.png'),
              ),
              addSpacer(12.0),
              // SizedBox(
              //   width: 78,
              //   child: Image.asset('asset/LightSutra.png'),
              // ),
              // addSpacer(12.0),
              const Divider(
                color: Colors.white,
                endIndent: 26,
                indent: 26,
                thickness: 0.5,
              ),
              buildDrawerItems(context),
            ],
          ),
        ),
      );

  Widget buildDrawerItems(BuildContext context) => Column(
        children: DrawerItems.all
            .map(
              (item) => ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
                leading: Icon(
                  item.icon,
                  color: Colors.white,
                ),
                title: Text(
                  item.title,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onTap: () => onSelectedItem(item),
              ),
            )
            .toList(),
      );
}
