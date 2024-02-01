import 'package:flutter/material.dart';
import 'package:galactic_scales/utils/functions.dart';

/* This component displays a popup diaglog with a title and description, providing additional details */
class PopupIconButton extends StatelessWidget {
  final String title;
  final String description;

  const PopupIconButton({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => Functions.showPopup(context, title, description), icon: const Icon(Icons.info));
  }
}
