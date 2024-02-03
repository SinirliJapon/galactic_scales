import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/model/quiz_question.dart';
import 'package:galactic_scales/provider/quiz_provider.dart';
import 'package:galactic_scales/resource/styles.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:galactic_scales/utils/descriptions.dart';
import 'package:galactic_scales/utils/functions.dart';
import 'package:galactic_scales/widgets/popup_icon_button.dart';
import 'package:galactic_scales/widgets/quiz_screen_widgets/quiz_image.dart';
import 'package:galactic_scales/widgets/quiz_screen_widgets/quiz_progress_indicator.dart';
import 'package:galactic_scales/widgets/quiz_screen_widgets/quiz_question_widget.dart';
import 'package:provider/provider.dart';

@RoutePage()
class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false).loadQuizData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final quizProvider = Provider.of<QuizProvider>(context);
    const quizActions = [PopupIconButton(title: Descriptions.quizScreenTitle, description: Descriptions.quizScreenDescription)];
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async => Functions.onWillPop(context, quizProvider.resetQuiz),
      child: Container(
        decoration: Styles.quizScreenBoxDecoration,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Solar System Quiz'),
            backgroundColor: Colors.transparent,
            foregroundColor: ThemeColor.quizScreenForegroundColor,
            actions: quizActions,
          ),
          body: Consumer<QuizProvider>(
            builder: (context, value, child) {
              if (value.isQuizDataLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (value.questions.isEmpty) {
                return const Center(child: Text('No Quiz Available'));
              } else {
                final questions = value.questions;
                int questionIndex = quizProvider.questionIndex;
                QuizQuestion? currentQuestion = questions[questionIndex];
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
            },
          ),
        ),
      ),
    );
  }
}
