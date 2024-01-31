import 'package:flutter/material.dart';
import 'package:galactic_scales/model/quiz_question.dart';

class QuizImage extends StatelessWidget {
  final List<QuizQuestion> questions;
  final int questionIndex;
  final double screenWidth;

  const QuizImage({Key? key, required this.questions, required this.questionIndex, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Image.network(questions[questionIndex].imageUrl, width: screenWidth / 1.8, height: screenWidth / 1.8),
              const Divider(height: 0, thickness: 0, color: Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}
