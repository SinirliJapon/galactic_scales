import 'package:flutter/material.dart';
import 'package:galactic_scales/resource/theme_color.dart';

class SpaceObjectAlertDialog extends StatelessWidget {
  final String title;
  final String details;

  const SpaceObjectAlertDialog({super.key, required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: AlertDialog(
        title: Text(title),
        content: Text(details),
        titlePadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ThemeColor.blackColor),
        contentTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: ThemeColor.defaultFontColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: ThemeColor.foregroundColor,
        alignment: Alignment.center,
        elevation: 2,
      ),
    );
  }
}
