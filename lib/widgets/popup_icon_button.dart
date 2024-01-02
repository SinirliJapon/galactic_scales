import 'package:flutter/material.dart';
import 'package:galactic_scales/resource/theme_color.dart';

class PopupIconButton extends StatelessWidget {
  final String title;
  final String description;

  const PopupIconButton({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => _showPopup(context, title, description), icon: const Icon(Icons.info));
  }
}

void _showPopup(BuildContext context, String title, String details) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: AlertDialog(
          title: Text(title),
          content: Text(details),
          titlePadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ThemeColor.blackColor),
          contentTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: ThemeColor.defaultFontColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          elevation: 2,
        ),
      );
    },
  );
}
