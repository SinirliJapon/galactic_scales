import 'package:flutter/material.dart';
import 'package:galactic_scales/resource/theme_color.dart';

class ExitConfirmationDialog extends StatelessWidget {
  final VoidCallback restartCallback;

  const ExitConfirmationDialog({Key? key, required this.restartCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 2,
      titlePadding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      contentPadding: const EdgeInsets.all(16),
      actionsPadding: const EdgeInsets.all(8),
      backgroundColor: ThemeColor.alertDialogBackground,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      titleTextStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: ThemeColor.blackColor),
      contentTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: ThemeColor.defaultFontColor),
      title: const Text('Exit Quiz'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SizedBox(height: 8), Text('Are you sure? This will reset your quiz.')],
      ),
      actions: [
        TextButton(
          onPressed: () {
            restartCallback();
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('Yes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ThemeColor.quizScreenFirstColor)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('No', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ThemeColor.quizScreenFirstColor)),
        ),
      ],
    );
  }
}
