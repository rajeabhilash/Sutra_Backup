import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sutra/util/constants/general.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sutra/util/prefs/user.dart';
import 'package:sutra/util/prefs/user_preferences.dart';
import 'package:sutra/util/widgets/profile_widget.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late UserData user;

  TextEditingController nameInput = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController mobileInput = TextEditingController();
  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  TextEditingController confirmPasswordInput = TextEditingController();

  int genderID = 1;
  int age = 0;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  DateTime? pickedDate;
  File? imageFile;
  String profileLocalPath = "";
  bool profileUpdated = false;
  late var image;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(
      r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character',
    )
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: "Please Enter Valid Email")
  ]);

  final dobValidator = MultiValidator([
    RequiredValidator(errorText: 'Date of Birth is required'),
    DateValidator('yyyy-mm-dd', errorText: "Please Select Valid Date"),
  ]);

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name and Surname is required'),
  ]);

  final signUpFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    dateInput.text = '';
    user = UserPreferences.getUser();
  }

  @override
  void dispose() {
    dateInput.dispose();
    nameInput.dispose();
    mobileInput.dispose();
    emailInput.dispose();
    passwordInput.dispose();
    confirmPasswordInput.dispose();
    super.dispose();
  }

  Future signUP() async {
    final isValid = signUpFormKey.currentState!.validate();
    if (!isValid) {
      showSnackBar(
        this.context,
        MessageType.errorMessage,
        'Please Fill the Registration Form Properly',
      );
      return;
    }

    showDialog(
      context: this.context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      getFreshValues();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailInput.text.trim(),
        password: passwordInput.text.trim(),
      );

      UserPreferences.setUser(user);
      Navigator.of(this.context).pop();
      Navigator.of(this.context).pop();
    } on FirebaseAuthException catch (e) {
      var message = e.message;
      showSnackBar(
          this.context, MessageType.errorMessage, "Error Occurred $message");
    }
  }

  getFreshValues() {
    setState(() {
      user.copy(fullName: nameInput.text.trim());
      user.copy(dateOfBirth: dateInput.text.trim());
      user.copy(gender: genderID);
      user.copy(age: age);
      user.copy(mobileNumber: mobileInput.text.trim());
      user.copy(emailID: emailInput.text.trim());
      user.copy(password: passwordInput.text.trim());
      user.copy(profileLocalPath: profileLocalPath);
      user.copy(isProfilePicUpdated: profileUpdated);
      user.copy(profileFirebasePath: "");
    });

    prettyPrint(tag: "Full Name ", value: user.fullName, type: DebugType.error);
    prettyPrint(
        tag: "Date of Birth ", value: user.dateOfBirth, type: DebugType.error);
    prettyPrint(tag: "Age", value: user.age, type: DebugType.error);
    prettyPrint(
        tag: "Profile Path",
        value: user.profileLocalPath,
        type: DebugType.error);
    prettyPrint(
        tag: "Firebase Path",
        value: user.profileFirebasePath,
        type: DebugType.error);
  }

  Future pickImage(ImageSource source) async {
    try {
      image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final name = basename(image.path);
      final imageFile = File('${directory.path}/$name');
      final compressedFileName = '${directory.path}/compressed_$name';
      final newImage = await File(image.path).copy(imageFile.path);

      final compressedFile =
          await testCompressAndGetFile(newImage, compressedFileName);

      profileLocalPath = compressedFileName;
      profileUpdated = true;

      setState(() {
        user = user.copy(profileLocalPath: compressedFileName);
        user = user.copy(isProfilePicUpdated: true);
        Navigator.of(this.context).pop();
      });
    } catch (e) {
      var error = e.toString();
      showSnackBar(
        this.context,
        MessageType.errorMessage,
        'Error Occurred : $error',
      );
    }
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minHeight: 600,
      quality: 65,
      rotate: 0,
    );

    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: signUpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addSpacer(horizontalSpace),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addSpacer(20.0),
                          SizedBox(
                            width: 70,
                            child: Hero(
                              tag: "SutraName",
                              child: Image.asset('asset/DarkSutra.png'),
                            ),
                          ),
                          const Text(
                            "Register Yourself.",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        child: Hero(
                          tag: 'SutraLogo',
                          child: Image.asset('asset/Brand/Black_Wire.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                addSpacer(24.0),
                const Divider(
                  endIndent: 26,
                  indent: 26,
                  thickness: 0.5,
                ),
                addSpacer(24.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: ProfileWidget(
                    imagePath: user.profileLocalPath,
                    isEdit: true,
                    onClicked: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            addSpacer(24.0),
                            const Text("Please Select Profile Picture : "),
                            addSpacer(12.0),
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text("From Camera"),
                              onTap: () => pickImage(ImageSource.camera),
                            ),
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text("From Gallery"),
                              onTap: () => pickImage(ImageSource.gallery),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                addSpacer(44.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: TextFormField(
                    controller: nameInput,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: nameValidator,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Full Name",
                      suffixIcon: Icon(Icons.abc),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (name) => user = user.copy(fullName: name),
                  ),
                ),
                addSpacer(14.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: TextFormField(
                    controller: dateInput,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: dobValidator,
                    readOnly: true,
                    onTap: () async {
                      pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now());

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate!);
                        setState(() {
                          dateInput.text = formattedDate;
                        });
                      } else {}
                    },
                    onChanged: (dob) {
                      user = user.copy(dateOfBirth: dob);
                      if (pickedDate != null) {
                        age = calculateAge(pickedDate!);
                        user = user.copy(age: calculateAge(pickedDate!));
                      }
                    },
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.cake),
                      border: OutlineInputBorder(),
                      labelText: "Date of Birth",
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                addSpacer(14.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: genderID,
                        onChanged: (val) {
                          setState(() {
                            genderID = 1;
                            user = user.copy(gender: genderID);
                          });
                        },
                      ),
                      const Text(
                        'Male',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Radio(
                        value: 2,
                        groupValue: genderID,
                        onChanged: (val) {
                          setState(() {
                            genderID = 2;
                            user = user.copy(gender: genderID);
                          });
                        },
                      ),
                      const Text(
                        'Female',
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                      Radio(
                        value: 3,
                        groupValue: genderID,
                        onChanged: (val) {
                          setState(() {
                            genderID = 3;
                            user = user.copy(gender: genderID);
                          });
                        },
                      ),
                      const Text(
                        'Transgender',
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ],
                  ),
                ),
                addSpacer(14.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: TextFormField(
                    controller: mobileInput,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MinLengthValidator(10,
                        errorText: "Please Enter Valid Phone no of Digit 10"),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mobile Number",
                      suffixIcon: Icon(Icons.phone_android),
                    ),
                    onChanged: (number) =>
                        user = user.copy(mobileNumber: number),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                addSpacer(14.0),
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
                    onChanged: (email) => user = user.copy(emailID: email),
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
                    onChanged: (password) =>
                        user = user.copy(password: password),
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
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    obscureText: _hidePassword,
                  ),
                ),
                addSpacer(14.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: TextFormField(
                    controller: confirmPasswordInput,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Conform password is required please enter';
                      }
                      if (value != passwordInput.text.trim()) {
                        return 'Confirm password not matching';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Confirm Password",
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            _hideConfirmPassword = !_hideConfirmPassword;
                          });
                        },
                        child: Icon(
                          _hideConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: _hideConfirmPassword,
                  ),
                ),
                addSpacer(24.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: const Text('Back'),
                      ),
                      FilledButton.icon(
                        icon: const Icon(Icons.verified_user),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 40,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: signUP,
                        label: const Text('Verify Account'),
                      ),
                    ],
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
