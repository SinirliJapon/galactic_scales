import 'package:flutter/material.dart';
import 'package:galactic_scales/provider/quiz_provider.dart';
import 'package:galactic_scales/resource/theme_color.dart';

class QuizProgressIndicator extends StatelessWidget {
  final QuizProvider quizProvider;

  const QuizProgressIndicator({Key? key, required this.quizProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: LinearProgressIndicator(
        value: quizProvider.progress,
        color: ThemeColor.quizIndicatorColor,
        backgroundColor: ThemeColor.quizScreenSecondaryColor,
      ),
    );
  }
}
