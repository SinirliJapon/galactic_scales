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

  static BoxDecoration quizScreenBoxDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: [ThemeColor.quizScreenFirstColor, ThemeColor.quizScreenSecondColor, ThemeColor.quizScreenThirdColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.5, 1.0],
      tileMode: TileMode.clamp,
    ),
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

  static InputDecoration spaceObjectSearchDecoration = InputDecoration(
    hintText: 'Search',
    hintStyle: const TextStyle(color: ThemeColor.foregroundColor, fontWeight: FontWeight.bold),
    prefixIcon: const Icon(Icons.search, color: ThemeColor.foregroundColor),
    contentPadding: const EdgeInsets.all(12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: ThemeColor.foregroundColor, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: ThemeColor.foregroundColor, width: 2.0),
    ),
  );

  static BoxDecoration spaceObjectBoxDecoration = const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    color: ThemeColor.spaceObjectBoxColor,
  );

  static TextStyle nickNameTextStyle = const TextStyle(color: ThemeColor.spaceObjectBoxColor, fontSize: 16);

  static TextStyle spaceObjectTextStyle = const TextStyle(fontWeight: FontWeight.w600, fontSize: 40, color: ThemeColor.spaceObjectBoxColor);
}
