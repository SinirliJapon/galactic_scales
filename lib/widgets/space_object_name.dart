import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';

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
          Text(object.name.toUpperCase(), style: spaceObjectTextStyle()),
          object.nickname.isEmpty
              ? Text(object.objectType.toUpperCase(), style: nickNameTextStyle())
              : Text(object.nickname.toUpperCase(), style: nickNameTextStyle()),
        ],
      ),
    );
  }
}

BoxDecoration spaceObjectBoxDecoration() {
  return const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)), color: Colors.white);
}

TextStyle nickNameTextStyle() => const TextStyle(color: Colors.white, fontSize: 16);

TextStyle spaceObjectTextStyle() => const TextStyle(fontWeight: FontWeight.w600, fontSize: 40, color: Colors.white);
