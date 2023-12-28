import 'package:flutter/material.dart';
import 'package:galactic_scales/resource/theme_color.dart';

abstract class Styles {
  static ButtonStyle quizDefaultButtonStyle = ButtonStyle(
    overlayColor: const MaterialStatePropertyAll(ThemeColor.quizDefaultButtonOverlayColor),
    foregroundColor: const MaterialStatePropertyAll(ThemeColor.quizDefaultButtonForegroundColor),
    backgroundColor: const MaterialStatePropertyAll(ThemeColor.quizDefaultButtonBackgroundColor),
    elevation: const MaterialStatePropertyAll(2),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: const BorderSide(color: Colors.black, width: 1),
    )),
  );
  static ButtonStyle quizCorrectButtonStyle = ButtonStyle(
    foregroundColor: const MaterialStatePropertyAll(ThemeColor.quizCorrectButtonForegroundColor),
    backgroundColor: const MaterialStatePropertyAll(ThemeColor.quizCorrectButtonBackgroundColor),
    elevation: const MaterialStatePropertyAll(2),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: const BorderSide(color: Colors.black, width: 1),
    )),
  );
  static ButtonStyle quizWrongButtonStyle = ButtonStyle(
    foregroundColor: const MaterialStatePropertyAll(ThemeColor.quizWrongButtonForegroundColor),
    backgroundColor: const MaterialStatePropertyAll(ThemeColor.quizWrongButtonBackgroundColor),
    elevation: const MaterialStatePropertyAll(2),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: const BorderSide(color: Colors.black, width: 1),
    )),
  );
  static BoxDecoration homeScreenBoxDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: [ThemeColor.homeScreenFirstColor, ThemeColor.homeScreenSecondColor, ThemeColor.homeScreenThirdColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.5, 1.0],
      tileMode: TileMode.clamp,
    ),
  );
}
