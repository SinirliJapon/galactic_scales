import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/routes/app_router.gr.dart';

class QuizButton extends StatelessWidget {
  const QuizButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        AutoRouter.of(context).push(const QuizRoute());
      },
      icon: const Icon(Icons.quiz),
    );
  }
}
