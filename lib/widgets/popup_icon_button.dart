import 'package:flutter/material.dart';

class PopupIconButton extends StatelessWidget {
  final String description;

  const PopupIconButton({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _showPopup(context, description);
        },
        icon: const Icon(Icons.info));
  }
}

void _showPopup(BuildContext context, String details) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(details, style: const TextStyle(fontSize: 18)),
          ),
        ],
        backgroundColor: Colors.white,
        actionsPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 2,
        alignment: Alignment.center,
      );
    },
  );
}
