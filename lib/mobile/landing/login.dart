import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sutra/util/prefs/user.dart';
import 'package:sutra/util/prefs/user_preferences.dart';
import 'package:sutra/mobile/landing/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sutra/util/constants/general.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late UserData user;
  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  bool _hidePassword = true;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: "Please Enter Valid Email")
  ]);

  final signInFormKey = GlobalKey<FormState>();

  Future signIN() async {
    final isValid = signInFormKey.currentState!.validate();
    if (!isValid) {
      showSnackBar(
        context,
        MessageType.errorMessage,
        'Please give proper credentials.!',
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailInput.text.trim(),
        password: passwordInput.text.trim(),
      );

      // indexPageKey.currentState!.popUntil((route) => route.isFirst);
      downloadProfileData();
      downloadProfilePicture();
      UserPreferences.setUser(user);

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      var message = e.message;
      showSnackBar(context, MessageType.errorMessage, "Error : $message");
      Navigator.of(context).pop();
    }
  }

  downloadProfileData() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    docUser.get().then((doc) {
      user = UserData.fromJSON(doc.data()!);
    });
  }

  downloadProfilePicture() async {
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference with an initial file path and name
    // final pathReference = storageRef.child("images/stars.jpg");
    final userID = FirebaseAuth.instance.currentUser!.uid;

    final islandRef = storageRef.child("user_profiles/$userID");

    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.absolute}/images/$userID.jpg";
    final file = File(filePath);

    user.copy(profileLocalPath: filePath);

    final downloadTask = islandRef.writeToFile(file);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          break;
        case TaskState.paused:
          break;
        case TaskState.success:
          print("Profile Path = $filePath");
          print("Profile Downloaded");
          break;
        case TaskState.canceled:
          break;
        case TaskState.error:
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser();
  }

  @override
  void dispose() {
    emailInput.dispose();
    passwordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: signInFormKey,
            child: Column(
              children: [
                addSpacer(74.0),
                SizedBox(
                  width: screenWidth / 2.25,
                  child: Hero(
                    tag: 'SutraLogo',
                    child: Image.asset('asset/Brand/Black_Wire.png'),
                  ),
                ),
                addSpacer(16.0),
                SizedBox(
                  width: screenWidth / 4.45,
                  child: Hero(
                    tag: "SutraName",
                    child: Image.asset('asset/DarkSutra.png'),
                  ),
                ),
                addSpacer(8.0),
                const Text(
                  "Map to find yourself",
                  style: TextStyle(fontFamily: 'Exo', fontSize: 22),
                ),
                addSpacer(40.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: TextFormField(
                    controller: emailInput,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: emailValidator,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email ID",
                      suffixIcon: Icon(Icons.mail_outline),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                addSpacer(14.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: TextFormField(
                    controller: passwordInput,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: passwordValidator,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Password",
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                        child: Icon(
                          _hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    obscureText: _hidePassword,
                  ),
                ),
                addSpacer(11.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password.?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                addSpacer(11.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: FilledButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: signIN,
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                addSpacer(24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                        ),
                      ),
                      Text("  Not Registered Yet.?  "),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                addSpacer(24.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: const Text('Go Back and Get Started'),
                  ),
                ),
                addSpacer(60.0),
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
                addSpacer(40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
