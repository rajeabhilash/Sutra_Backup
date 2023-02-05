import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sutra/util/prefs/user.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUser = 'userData';

  static const baseUser = UserData(
    fullName: "Raje Abhilash",
    dateOfBirth: "1996-07-14",
    age: 26,
    gender: 1,
    emailID: "rajeabhilashmohite@gmail.com",
    isDarkMode: false,
    mobileNumber: '8378881434',
    password: "Password@123",
    profileFirebasePath: 'https://i.pravatar.cc/300',
    profileLocalPath:
        "https://raw.githubusercontent.com/rajeabhilash/Sutra/main/asset/user.png",
    isProfilePicUpdated: false,
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(UserData user) async {
    final userDataJSONString = jsonEncode(user.toJSON());
    await _preferences.setString(_keyUser, userDataJSONString);
  }

  static String userDataString(UserData user) {
    return jsonEncode(user.toJSON());
  }

  static bool isExists() => _preferences.containsKey(_keyUser);

  static Future<bool> clearUserData() {
    return _preferences.remove(_keyUser);
  }

  static UserData getUser() {
    final userDataJSONString = _preferences.getString(_keyUser);
    if (userDataJSONString == null) {
      return baseUser;
    } else {
      return UserData.fromJSON(jsonDecode(userDataJSONString));
    }
  }
}
