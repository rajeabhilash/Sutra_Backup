import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sutra/util/constants/general.dart';

class SimpleTextInput extends StatelessWidget {
  Icon suffixIcon;
  TextEditingController inputController;
  var inputType;
  String? labelName;

  SimpleTextInput({
    super.key,
    required this.suffixIcon,
    required this.labelName,
    required this.inputController,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
      child: TextFormField(
        controller: inputController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelName,
          suffixIcon: suffixIcon,
        ),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
