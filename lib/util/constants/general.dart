// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

double horizontalSpace = 25.0;
bool isSutraDark = false;

Color errorColor = const Color(0xFFE23636);
Color warningColor = const Color(0xFFEDB95E);
Color successColor = const Color(0xFF82DD55);
Color infoColor = const Color(0xFFC8CDD0);

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printError(String text) {
  print('\x1B[31m$text\x1B[0m');
}

enum DebugType { error, info, url, response, statusCode }

prettyPrint(
    {required String tag,
    required dynamic value,
    DebugType type = DebugType.info}) {
  switch (type) {
    case DebugType.statusCode:
      {
        debugPrint('\x1B[33m${"💎 STATUS CODE $tag: $value"}\x1B[0m');
        break;
      }
    case DebugType.info:
      {
        debugPrint('\x1B[32m${"⚡ INFO $tag: $value"}\x1B[0m');
        break;
      }
    case DebugType.error:
      {
        debugPrint('\x1B[31m${"🚨 ERROR $tag: $value"}\x1B[0m');
        break;
      }
    case DebugType.response:
      {
        debugPrint('\x1B[36m${"💡 RESPONSE $tag: $value"}\x1B[0m');
        break;
      }
    case DebugType.url:
      {
        debugPrint('\x1B[34m${"📌 URL $tag: $value"}\x1B[0m');
        break;
      }
  }
}

Widget addSpacer(val) {
  return SizedBox(height: val);
}

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );

enum MessageType {
  successMessage,
  errorMessage,
  warningMessage,
  informationMessage,
}

showSnackBar(context, messageType, message) {
  Color? color;

  switch (messageType) {
    case MessageType.errorMessage:
      color = errorColor;
      break;
    case MessageType.successMessage:
      color = successColor;
      break;
    case MessageType.informationMessage:
      color = infoColor;
      break;
    case MessageType.warningMessage:
      color = warningColor;
      break;
    default:
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(message),
    ),
  );
}

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
