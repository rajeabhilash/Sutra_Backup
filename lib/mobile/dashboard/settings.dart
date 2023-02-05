import 'package:flutter/material.dart';
import 'package:sutra/util/prefs/user.dart';
import 'package:sutra/util/prefs/user_preferences.dart';
import 'package:sutra/mobile/dashboard/drawer/drawer_menu.dart';
import 'package:sutra/util/widgets/profile_widget.dart';

class Settings extends StatefulWidget {
  final VoidCallback openDrawer;

  const Settings({
    super.key,
    required this.openDrawer,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserData user = UserPreferences.getUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DrawerWidgetMenu(
          onClicked: widget.openDrawer,
        ),
        backgroundColor: Colors.transparent,
        title: Text(user.fullName),
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Local Image'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProfileWidget(
                imagePath: user.profileLocalPath,
                onClicked: () {},
                isEdit: false,
              ),
            ),
            Text('Firebase Image'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProfileWidget(
                imagePath: user.profileFirebasePath,
                onClicked: () {},
                isEdit: false,
              ),
            ),
            ListTile(
              title: Text("Email"),
              subtitle: Text(user.emailID),
            ),
            ListTile(
              title: Text("Mobile"),
              subtitle: Text(user.mobileNumber),
            ),
            ListTile(
              title: Text("Age"),
              subtitle: Text("${user.age}"),
            ),
            ListTile(
              title: Text("Password"),
              subtitle: Text(user.password),
            ),
            ListTile(
              title: Text("Date of Birth"),
              subtitle: Text(user.dateOfBirth),
            ),
          ],
        ),
      ),
    );
  }
}
