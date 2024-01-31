import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/resource/styles.dart';

class SpaceObjectOrbits extends StatelessWidget {
  final SpaceObject object;

  const SpaceObjectOrbits(this.object, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(object.orbits.toString(), style: Styles.spaceObjectTextStyle),
          Text('ORBITS', style: Styles.nickNameTextStyle),
        ],
      ),
    );
  }
}
