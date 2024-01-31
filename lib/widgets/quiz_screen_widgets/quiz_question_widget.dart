import 'package:flutter/material.dart';
import 'package:galactic_scales/model/quiz_question.dart';
import 'package:galactic_scales/resource/theme_color.dart';

class QuizQuestionWidget extends StatelessWidget {
  final double screenHeight;
  final QuizQuestion? currentQuestion;

  const QuizQuestionWidget({super.key, required this.screenHeight, required this.currentQuestion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: screenHeight / 9,
        child: Text(currentQuestion!.question, style: const TextStyle(fontSize: 20, color: ThemeColor.foregroundColor)),
      ),
    );
  }
}
