class UserData {
  final String fullName;
  final String dateOfBirth;
  final int age;
  final int gender;
  final String mobileNumber;
  final String emailID;
  final String password;
  final bool isDarkMode;
  final String profileLocalPath;
  final bool isProfilePicUpdated;
  final String profileFirebasePath;

  // bool isPlatformTheme

  const UserData({
    required this.profileLocalPath,
    required this.profileFirebasePath,
    required this.fullName,
    required this.dateOfBirth,
    required this.age,
    required this.gender,
    required this.mobileNumber,
    required this.emailID,
    required this.password,
    required this.isDarkMode,
    required this.isProfilePicUpdated,
  });

  UserData copy(
          {String? profileLocalPath,
          String? profileFirebasePath,
          String? fullName,
          String? dateOfBirth,
          int? age,
          int? gender,
          String? mobileNumber,
          String? emailID,
          String? password,
          bool? isDarkMode,
          bool? isProfilePicUpdated}) =>
      UserData(
        profileFirebasePath: profileFirebasePath ?? this.profileFirebasePath,
        profileLocalPath: profileLocalPath ?? this.profileLocalPath,
        fullName: fullName ?? this.fullName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        emailID: emailID ?? this.emailID,
        password: password ?? this.password,
        isDarkMode: isDarkMode ?? this.isDarkMode,
        isProfilePicUpdated: isProfilePicUpdated ?? this.isProfilePicUpdated,
      );

  Map<String, dynamic> toJSON() => {
        'profileFirebasePath': profileFirebasePath,
        'profileLocalPath': profileLocalPath,
        'fullName': fullName,
        'dateOfBirth': dateOfBirth,
        'age': age,
        'gender': gender,
        'mobileNumber': mobileNumber,
        'emailID': emailID,
        'password': password,
        'isDarkMode': isDarkMode,
        'isProfilePicUpdated': isProfilePicUpdated
      };

  static UserData fromJSON(Map<String, dynamic> userDataJSONString) => UserData(
        profileFirebasePath: userDataJSONString['profileFirebasePath'],
        profileLocalPath: userDataJSONString['profileLocalPath'],
        fullName: userDataJSONString['fullName'],
        dateOfBirth: userDataJSONString['dateOfBirth'],
        age: userDataJSONString['age'],
        gender: userDataJSONString['gender'],
        mobileNumber: userDataJSONString['mobileNumber'],
        emailID: userDataJSONString['emailID'],
        password: userDataJSONString['password'],
        isDarkMode: userDataJSONString['isDarkMode'],
        isProfilePicUpdated: userDataJSONString['isProfilePicUpdated'],
      );
}
