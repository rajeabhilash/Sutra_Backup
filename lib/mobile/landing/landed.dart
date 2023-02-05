import 'package:flutter/material.dart';
import 'package:sutra/util/constants/general.dart';
import 'package:sutra/mobile/landing/login.dart';
import 'package:sutra/mobile/landing/register.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addSpacer(screenHeight / 4.75),
              SizedBox(
                width: screenWidth / 1.62,
                child: Hero(
                  tag: 'SutraLogo',
                  child: Image.asset('asset/Brand/Black_Wire.png'),
                ),
              ),
              addSpacer(16.0),
              SizedBox(
                width: screenWidth / 3.2,
                child: Hero(
                  tag: "SutraName",
                  child: Image.asset('asset/DarkSutra.png'),
                ),
              ),
              addSpacer(11.0),
              const Text("Map to find yourself",
                  style: TextStyle(fontSize: 22)),
              addSpacer(88.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Register(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(
                      color: isSutraDark ? Colors.white : Colors.black,
                      width: 1.25,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Get Started',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
              addSpacer(14.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already User.? ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: const Text(
                      ' Log In.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              addSpacer(92.0),
              const Text(
                'Copyright © Vashishtha Enterprise - 2023',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Gotu",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  letterSpacing: 1.125,
                ),
              ),
              addSpacer(25.0),
            ],
          ),
        ),
      ),
    );
  }
}
