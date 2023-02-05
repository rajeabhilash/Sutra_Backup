import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sutra/util/constants/general.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailInput = TextEditingController();

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: "Please Enter Valid Email")
  ]);

  final resetPasswordFormKey = GlobalKey<FormState>();

  Future resetPassword() async {
    final isValid = resetPasswordFormKey.currentState!.validate();
    if (!isValid) {
      showSnackBar(
        context,
        MessageType.errorMessage,
        'Please Enter EMail ID to reset Password.!',
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
      var emailID = emailInput.text.trim();
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailID,
      );
      showSnackBar(
        context,
        MessageType.successMessage,
        'Password Reset Email Sent to $emailID',
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      var message = e.message;
      showSnackBar(context, MessageType.errorMessage, "Error $message");
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    emailInput.dispose();
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
            key: resetPasswordFormKey,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalSpace + 5.0),
                  child: Row(
                    children: const [
                      Text(
                        "Send Password Reset Link to : ",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
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
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                addSpacer(14.0),
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
                        icon: const Icon(Icons.lock_reset),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: resetPassword,
                        label: const Text('Reset Password'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
