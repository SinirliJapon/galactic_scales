class QuizQuestion {
  final String question;
  final List<String> options;
  final String imageUrl;
  final int answerIndex;

  QuizQuestion({required this.question, required this.options, required this.answerIndex, required this.imageUrl});
}
