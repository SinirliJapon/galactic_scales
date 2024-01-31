import 'package:flutter/material.dart';
import 'package:galactic_scales/widgets/quiz_screen_widgets/exit_confirmation_dialog.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/distance_slider.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class Functions {
  /* This function is for handling the system back button press in quiz screen */
  static Future<bool> onWillPop(BuildContext context, VoidCallback reset) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => ExitConfirmationDialog(restartCallback: reset),
    );
    return confirmed ?? false;
  }

  /* This function is for direct the user for intended url page */
  static void urlLaunch(String url) {
    final Uri uri = Uri.parse(url);
    try {
      launchUrl(uri);
    } catch (e) {
      rethrow;
    }
  }

  /* This function calculates the distances or units in a more concise form */
  static scientificDistance(double value) {
    final scientific = value.toStringAsExponential(2);
    final parts = scientific.split('e');
    return DistanceTrailing(parts: parts);
  }

/* This function calculates the mass in a more concise form */
  static String scientificMass(double value) {
    final scientific = value.toStringAsExponential(2);
    final parts = scientific.split('e');
    return '${parts[0]} × 10^${int.parse(parts[1])}';
  }
}
