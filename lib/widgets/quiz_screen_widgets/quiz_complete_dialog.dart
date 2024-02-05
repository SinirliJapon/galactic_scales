import 'package:flutter/material.dart';
import 'package:galactic_scales/resource/theme_color.dart';

class QuizCompleteDialog extends StatelessWidget {
  final double successRate;
  final VoidCallback restartCallback;
  final VoidCallback startNewQuizCallback;

  const QuizCompleteDialog({Key? key, required this.successRate, required this.restartCallback, required this.startNewQuizCallback}) : super(key: key);

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
      title: const Text('Quiz Complete'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const SizedBox(height: 8), Text('Your success rate: ${(successRate * 100).toStringAsFixed(1)}%')],
      ),
      actions: [
        TextButton(
          onPressed: () {
            restartCallback();
            Navigator.pop(context);
          },
          child: const Text('Restart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ThemeColor.quizScreenThirdColor)),
        ),
        TextButton(
          onPressed: () {
            startNewQuizCallback();
            Navigator.pop(context);
          },
          child: const Text('New Quiz', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ThemeColor.quizScreenThirdColor)),
        ),
        TextButton(
          onPressed: () {
            restartCallback();
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('Exit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ThemeColor.quizScreenThirdColor)),
        ),
      ],
    );
  }
}
