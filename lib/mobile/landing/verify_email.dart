import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sutra/util/constants/general.dart';
import 'package:sutra/util/prefs/user.dart';
import 'package:sutra/util/prefs/user_preferences.dart';
import 'package:sutra/mobile/dashboard/home.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canSendEmail = true;
  String? emailID;
  Timer? timer;

  late UserData user;
  UploadTask? uploadTask;

  @override
  void initState() {
    super.initState();

    user = UserPreferences.getUser();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    emailID = FirebaseAuth.instance.currentUser!.email;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (timer) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      await addUserToDB();
      if (user.isProfilePicUpdated) await uploadFile();
      UserPreferences.setUser(user);
      timer?.cancel();
    }
  }

  Future addUserToDB() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await docUser.set(user.toJSON());
  }

  Future uploadFile() async {
    final path = 'user_profiles/${FirebaseAuth.instance.currentUser!.uid}';
    final file = File(user.profileLocalPath);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    user.copy(profileFirebasePath: urlDownload);
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      // ignore: use_build_context_synchronously
      showSnackBar(context, MessageType.successMessage,
          'Verification Mail Sent.!, Please Check Mailbox.');

      setState(() => canSendEmail = false);
      await Future.delayed(const Duration(seconds: 10));
      setState(() => canSendEmail = true);
    } catch (e) {
      var message = e.toString();
      showSnackBar(
          context, MessageType.errorMessage, "Error Occurred $message");
    }
  }

  doNothing() {}

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenWidth = size.width;

    return isEmailVerified
        ? const HomePage()
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
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
                      style: TextStyle(
                          fontFamily: 'Exo',
                          fontSize: 22,
                          fontWeight: FontWeight.normal),
                    ),
                    addSpacer(40.0),
                    Padding(
                      padding: EdgeInsets.all(horizontalSpace),
                      child: Text(
                        "Email Verification link is send to $emailID. Please Verify your Email.",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    addSpacer(14.0),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalSpace),
                      child: FilledButton.icon(
                        icon: const Icon(Icons.mail_outline),
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          canSendEmail ? sendVerificationEmail() : doNothing();
                        },
                        label: const Text('Resend Verification Mail'),
                      ),
                    ),
                    addSpacer(18.0),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalSpace),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
