import 'package:flutter/material.dart';
import 'package:galactic_scales/model/quiz_question.dart';
import 'package:galactic_scales/provider/quiz_provider.dart';
import 'package:galactic_scales/resource/theme_color.dart';

class QuizWidget extends StatelessWidget {
  final List<QuizQuestion> questions;
  final QuizProvider quizProvider;

  const QuizWidget({Key? key, required this.questions, required this.quizProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int questionIndex = quizProvider.questionIndex;
    QuizQuestion? currentQuestion = questions[questionIndex];
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        QuizProgressIndicator(quizProvider: quizProvider),
        QuizImage(questions: questions, questionIndex: questionIndex, screenWidth: screenWidth),
        Column(
          children: [
            QuizQuestionWidget(screenHeight: screenHeight, currentQuestion: currentQuestion),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 1,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              childAspectRatio: 7,
              children: List.generate(
                currentQuestion.options.length,
                (index) {
                  return ElevatedButton(
                    style: quizProvider.buttonStyles![index],
                    onPressed: () => quizProvider.handleAnswer(index, currentQuestion.answerIndex, context),
                    child: Padding(padding: const EdgeInsets.all(16.0), child: Text(currentQuestion.options[index])),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
        child: Text(currentQuestion!.question, style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}

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
