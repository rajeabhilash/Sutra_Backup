import 'package:sutra/util/prefs/user.dart';

class ProfileBase {
  ProfileBase();
  Future<bool?> uploadProfile(UserData userData) async {
    // This will upload all the data for the first Time Including images.
    // Create user Profile with Authentication.
    // Upload Data to Firestore Database.
    // Upload Profile Picture to Firebase Storage.
    // Assign that Data to the User Profile in Preferences.
    return false;
  }

  Future<bool?> downloadProfile(UserData userData) async {
    // This will download all the data for the first time Including Images.
    // Sign In to Firebase Authentication.
    // Download Data from Firestore Database.
    // Download Profile Picture from Firebase Storage.
    // Assign that Data to the User Profile in Preferences.
    return false;
  }

  Future<bool?> updateProfile(String uid, UserData userData) async {}

  Future<bool?> deleteProfile(String uid, UserData userData) async {}
}

class LevelBase {
  LevelBase() {
    // This will do operations re
    //lated to Levels
  }
}
