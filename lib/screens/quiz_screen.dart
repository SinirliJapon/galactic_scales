// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/provider/quiz_provider.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:galactic_scales/utils/descriptions.dart';
import 'package:galactic_scales/widgets/popup_icon_button.dart';
import 'package:galactic_scales/widgets/quiz_widget.dart';
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
    final quizProvider = Provider.of<QuizProvider>(context);
    // TODO: Fix here !!
    return WillPopScope(
      onWillPop: () => quizProvider.onWillPop(context, quizProvider.resetQuiz),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ThemeColor.quizScreenFirstColor, ThemeColor.quizScreenSecondColor, ThemeColor.quizScreenThirdColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Solar System Quiz'),
            backgroundColor: Colors.transparent,
            foregroundColor: ThemeColor.quizScreenForegroundColor,
            actions: const [PopupIconButton(title: Descriptions.quizScreenTitle, description: Descriptions.quizScreenDescription)],
          ),
          body: Consumer<QuizProvider>(
            builder: (context, value, child) {
              if (value.isQuizDataLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (value.questions.isEmpty) {
                return const Center(child: Text('No Quiz Available'));
              } else {
                return QuizWidget(questions: value.questions, quizProvider: quizProvider);
              }
            },
          ),
        ),
      ),
    );
  }
}
