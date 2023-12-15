import 'package:flutter/material.dart';
import 'package:galactic_scales/provider/quiz_provider.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:galactic_scales/widgets/quiz_widget.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      backgroundColor: ThemeColor.quizScreenBackgroundColor,
      appBar: AppBar(
        title: const Text('Solar System Quiz'),
        backgroundColor: ThemeColor.quizScreenBackgroundColor,
        foregroundColor: ThemeColor.quizScreenForegroundColor,
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
    );
  }
}
