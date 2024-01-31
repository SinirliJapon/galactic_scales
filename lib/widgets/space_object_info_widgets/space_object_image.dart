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
              title: Text('${object.name} (${object.nickname})'),
              content: Text(object.description),
              titlePadding: const EdgeInsets.all(20),
              contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ThemeColor.blackColor),
              contentTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: ThemeColor.defaultFontColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              backgroundColor: ThemeColor.foregroundColor,
              alignment: Alignment.center,
              elevation: 2,
            );
          },
        );
      },
      child: Image.network(object.image, height: screenHeight / 2),
    );
  }
}
