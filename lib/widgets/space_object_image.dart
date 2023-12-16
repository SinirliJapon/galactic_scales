import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/resource/theme_color.dart';

class SpaceObjectImage extends StatelessWidget {
  const SpaceObjectImage({super.key, required this.object, required this.screenHeight});

  final SpaceObject object;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 2,
              titlePadding: const EdgeInsets.only(top: 32, left: 16, right: 16),
              contentPadding: const EdgeInsets.all(16),
              actionsPadding: const EdgeInsets.all(8),
              backgroundColor: ThemeColor.alertDialogBackground,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              titleTextStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: ThemeColor.blackColor),
              contentTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: ThemeColor.defaultFontColor),
              title: Text('${object.name} (${object.nickname})'),
              content: Text(object.description),
            );
          },
        );
      },
      child: Image.network(object.image, height: screenHeight / 2),
    );
  }
}
