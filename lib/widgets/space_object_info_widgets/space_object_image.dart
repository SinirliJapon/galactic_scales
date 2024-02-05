import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/utils/functions.dart';

class SpaceObjectImage extends StatelessWidget {
  const SpaceObjectImage({super.key, required this.object});

  final SpaceObject object;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Functions.showPopup(context, '${object.name} (${Functions.getNickname(object)})', object.description),
      child: CachedNetworkImage(imageUrl: object.image, height: screenHeight / 2),
    );
  }
}
