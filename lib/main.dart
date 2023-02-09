import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:sutra/util/prefs/user_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sutra/util/constants/general.dart';
import 'package:sutra/redirect_devices.dart';
import 'package:sutra/desktop/index.dart';
import 'package:sutra/tablet/index.dart';
import 'package:sutra/mobile/index.dart';
import 'package:sutra/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform != TargetPlatform.windows) {
    await Firebase.initializeApp();
    await UserPreferences.init();
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const StartSutra(),
    ),
  );
}

final sutraKey = GlobalKey<NavigatorState>();

class StartSutra extends StatelessWidget {
  const StartSutra({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: isSutraDark ? SutraTheme.darkTheme : SutraTheme.lightTheme,
      builder: (context, sutraTheme) {
        return MaterialApp(
          key: sutraKey,
          title: "The Sutra",
          debugShowCheckedModeBanner: false,
          theme: sutraTheme,
          home: const RedirectDevice(
            mobileDevice: MobileSplash(),
            tabletDevice: TabletSplash(),
            desktopDevice: DesktopSplash(),
          ),
        );
      },
    );
  }
}
