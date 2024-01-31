import 'package:flutter/material.dart';
import 'package:galactic_scales/utils/functions.dart';

/* This component is a button that directs the user to object's wikipedia page */
class LinkIconButton extends StatelessWidget {
  final String url;
  const LinkIconButton({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Functions.urlLaunch(url),
      icon: const Icon(Icons.language),
    );
  }
}
