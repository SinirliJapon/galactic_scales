import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/resource/theme_color.dart';

class SpaceObjectOrbits extends StatelessWidget {
  final SpaceObject object;

  const SpaceObjectOrbits(this.object, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth / 2.2,
      height: screenHeight / 12,
      decoration: BoxDecoration(border: Border.all(color: ThemeColor.spaceObjectBoxColor, width: 0.3)),
      child: ListTile(
        iconColor: ThemeColor.spaceObjectBoxColor,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        subtitleTextStyle: TextStyle(color: ThemeColor.spaceObjectBoxColor.withOpacity(0.5), fontSize: screenHeight / 60),
        leading: const Icon(Icons.wifi_protected_setup),
        title: Text('${object.orbits.toInt()} DAYS'),
        subtitle: const Text('ORBITS'),
      ),
    );
  }
}
