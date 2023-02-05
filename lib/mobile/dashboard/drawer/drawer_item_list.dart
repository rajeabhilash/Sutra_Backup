import 'package:flutter/material.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_item.dart';

class DrawerItems {
  static const home = DrawerItem(title: "Home", icon: Icons.home_rounded);
  static const insights =
      DrawerItem(title: "Insights", icon: Icons.insights_rounded);
  static const explore =
      DrawerItem(title: "Explore", icon: Icons.explore_rounded);
  static const favorites =
      DrawerItem(title: "Favorites", icon: Icons.favorite_rounded);
  static const knowledge =
      DrawerItem(title: "Knowledge", icon: Icons.auto_stories_rounded);
  static const settings =
      DrawerItem(title: "Settings", icon: Icons.settings_rounded);
  static const logout = DrawerItem(title: "Logout", icon: Icons.logout_rounded);

  static final List<DrawerItem> all = [
    home,
    insights,
    explore,
    favorites,
    knowledge,
    settings,
    logout
  ];
}
