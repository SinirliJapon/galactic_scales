import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/resource/styles.dart';
import 'package:galactic_scales/utils/functions.dart';

class SpaceObjectName extends StatelessWidget {
  final SpaceObject object;

  const SpaceObjectName(this.object, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(object.name.toUpperCase(), style: Styles.spaceObjectTextStyle),
          object.nickname.isEmpty
              ? Text(object.objectType.toUpperCase(), style: Styles.nickNameTextStyle)
              : Text(Functions.getNickname(object).toUpperCase(), style: Styles.nickNameTextStyle),
        ],
      ),
    );
  }
}
