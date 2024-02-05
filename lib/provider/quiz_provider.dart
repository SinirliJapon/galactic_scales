import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galactic_scales/model/quiz_question.dart';
import 'package:galactic_scales/resource/styles.dart';
import 'package:galactic_scales/widgets/quiz_screen_widgets/quiz_complete_dialog.dart';

class QuizProvider extends ChangeNotifier {
  late List<QuizQuestion> _questions = [];
  late final List<QuizQuestion> _correctQuestions = [];
  late final List<QuizQuestion> _wrongQuestions = [];
  final int totalQuestions = 5;
  late int questionIndex = 0;
  late bool isQuizDataLoading = false;
  late bool isLoading = false;
  late List<ButtonStyle>? buttonStyles;

  QuizProvider() {
    buttonStyles = List.generate(4, (_) => Styles.quizDefaultButtonStyle);
  }

  List<QuizQuestion> get questions => _questions;

  double get progress => (_correctQuestions.length + _wrongQuestions.length) / totalQuestions;

  double get successRate => (_correctQuestions.length) / totalQuestions;

  bool get completed => !(questionIndex < _questions.length - 1);

  Future<void> loadQuizData(BuildContext context) async {
    isQuizDataLoading = true;
    notifyListeners();
    try {
      String jsonData = await rootBundle.loadString('assets/data/quiz_data.json');
      List<dynamic> jsonList = json.decode(jsonData);

      jsonList.shuffle();

      jsonList = jsonList.take(5).toList();

      _questions = jsonList.map((item) {
        return QuizQuestion(
          question: item['question'],
          options: List<String>.from(item['options']),
          imageUrl: item['imageUrl'],
          answerIndex: item['answerIndex'],
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isQuizDataLoading = false;
      notifyListeners();
    }
  }

  Future<void> handleAnswer(int optionIndex, int index, BuildContext context) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      if (optionIndex == index) {
        buttonStyles![index] = Styles.quizCorrectButtonStyle;
        if (questionIndex < _questions.length) {
          markAsCorrect(_questions[questionIndex]);
        }
      } else {
        buttonStyles![optionIndex] = Styles.quizWrongButtonStyle;
        buttonStyles![index] = Styles.quizCorrectButtonStyle;
        if (questionIndex < _questions.length) {
          markAsWrong(_questions[questionIndex]);
        }
      }

      await Future.delayed(const Duration(seconds: 1));

      if (questionIndex < _questions.length - 1) {
        questionIndex++;
        buttonStyles = List.generate(4, (_) => Styles.quizDefaultButtonStyle);
        notifyListeners();
      } else {
        await Future.delayed(const Duration(milliseconds: 100)).then((value) => showCompleteDialog(context));
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> showCompleteDialog(BuildContext context) async {
    isLoading = true;

    try {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => QuizCompleteDialog(successRate: successRate, restartCallback: resetQuiz, startNewQuizCallback: () => startNewQuiz(context)),
      );
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void startNewQuiz(BuildContext context) async{
    questionIndex = 0;
    isLoading = false;
    buttonStyles = List.generate(4, (_) => Styles.quizDefaultButtonStyle);
    _correctQuestions.clear();
    _wrongQuestions.clear();
    _questions = [];
    await loadQuizData(context);
    notifyListeners();
  }

  void resetQuiz() {
    questionIndex = 0;
    isLoading = false;
    buttonStyles = List.generate(4, (_) => Styles.quizDefaultButtonStyle);
    _correctQuestions.clear();
    _wrongQuestions.clear();
    notifyListeners();
  }

  void markAsCorrect(QuizQuestion question) {
    _correctQuestions.add(question);
    notifyListeners();
  }

  void markAsWrong(QuizQuestion question) {
    _wrongQuestions.add(question);
    notifyListeners();
  }
}
