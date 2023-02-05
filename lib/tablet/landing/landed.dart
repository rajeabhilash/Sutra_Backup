import 'package:flutter/material.dart';
import 'package:sutra/mobile/dashboard/home.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = false;
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    Future<void> _showSimpleDialog() async {
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              // <-- SEE HERE
              title: const Text(
                  'Sorry for Inconvenience, Only Mobile version available for this app. Tablet Version is under construction'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok, Let me Know.'),
                ),
              ],
            );
          });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight / 6),
                SizedBox(
                  width: 400,
                  child: Hero(
                    tag: 'SutraLogo',
                    child: Image.asset(isDark
                        ? 'asset/Brand/White_Wire.png'
                        : 'asset/Brand/Black_Wire.png'),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  child: Hero(
                    tag: "SutraName",
                    child: Image.asset(isDark
                        ? 'asset/LightSutra.png'
                        : 'asset/DarkSutra.png'),
                  ),
                ),
                SizedBox(height: 14),
                const Text(
                  "Map to find yourself",
                  style: TextStyle(
                      fontFamily: 'Exo',
                      fontSize: 22,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 80),
                GestureDetector(
                  onTap: () => _showSimpleDialog(),
                  child: Container(
                    width: 400,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(
                            color: isDark ? Colors.white : Colors.black,
                            width: 1.25),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: const Center(
                      child: Text(
                        'Get Started',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Exo",
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already User.?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Exo",
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          letterSpacing: 0.0,
                        )),
                    GestureDetector(
                      onTap: () => _showSimpleDialog(),
                      child: const Text(' Log In.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Exo",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            letterSpacing: 0.0,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 90),
                const Text(
                  'Copyright © Vashishtha Enterprise - 2023',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Gotu",
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    letterSpacing: 0.0,
                  ),
                ),
                SizedBox(height: 25),
              ]),
        ),
      ),
    );
  }
}
