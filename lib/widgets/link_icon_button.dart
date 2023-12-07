import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkIconButton extends StatelessWidget {
  final String url;
  const LinkIconButton({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          urlLaunch(url);
        },
        icon: const Icon(Icons.share));
  }
}

void urlLaunch(String url) {
  final Uri uri = Uri.parse(url);
  try {
    launchUrl(uri);
  } catch (e) {
    rethrow;
  }
}
