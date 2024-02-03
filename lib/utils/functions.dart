import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/widgets/quiz_screen_widgets/exit_confirmation_dialog.dart';
import 'package:galactic_scales/widgets/space_object_alert_dialog.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/distance_slider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class Functions {
  /* This function is for handling the system back button press in quiz screen */
  static Future<bool> onWillPop(BuildContext context, VoidCallback reset) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => ExitConfirmationDialog(restartCallback: reset),
        ) ??
        false;
  }

  static void showPopup(BuildContext context, String title, String details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SpaceObjectAlertDialog(
          title: title,
          details: details,
        );
      },
    );
  }

  static void urlLaunch(String url) {
    final Uri uri = Uri.parse(url);
    try {
      launchUrl(uri);
    } catch (e) {
      rethrow;
    }
  }

  static double getSliderDistance(SpaceObject object) {
    final double distance = (object.id == 0 || object.id == 10) ? object.distanceFromEarth : object.distanceFromSun;
    return distance;
  }

  static String getSliderDescription(SpaceObject object) {
    final String description = (object.id == 0 || object.id == 10) ? 'Distance from Earth' : 'Distance from Sun';
    return description;
  }

  static calculateScinetificDistance(double value) {
    final scientific = value.toStringAsExponential(2);
    final parts = scientific.split('e');
    return DistanceTrailing(parts: parts);
  }

  static String calculateScientificMass(double value) {
    final scientific = value.toStringAsExponential(2);
    final parts = scientific.split('e');
    return '${parts[0]} × 10^${int.parse(parts[1])}';
  }

  static double calculateVolume(double radius) {
    double volume = (4 / 3) * pi * pow(radius, 3);
    return volume;
  }

  static String getComparisonDetails(SpaceObject object) {
    final double volumeComparisonForSun = calculateVolume(1391000) / calculateVolume(12742);
    final double volumeComparisonForOthers = calculateVolume(1391000) / calculateVolume(object.size);
    final int volumeComparison = object.id == 0 ? volumeComparisonForSun.toInt() : volumeComparisonForOthers.toInt();
    final String objectName = object.id == 0 ? 'Earth' : object.name;
    final String formattedComparison = NumberFormat("#,##0").format(volumeComparison);
    return '$formattedComparison $objectName could fit in the Sun';
  }

  static String getComparisonTitle(SpaceObject object) {
    const String subtitleForSun = 'COMPARISON WIHT EARTH';
    const String subtitleForOtherObjects = 'COMPARISON WITH SUN';
    final String comparisonTitle = object.id == 0 ? subtitleForSun : subtitleForOtherObjects;
    return comparisonTitle;
  }
}
