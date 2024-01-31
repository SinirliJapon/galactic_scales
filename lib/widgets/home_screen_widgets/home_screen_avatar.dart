import 'package:flutter/material.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';

/* This component represents the home screen list tile element's avatar */
class HomeScreenAvatar extends StatelessWidget {
  const HomeScreenAvatar({
    super.key,
    required this.imageUrl,
    required this.screenHeight,
  });

  final String imageUrl;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return GFAvatar(
      shape: GFAvatarShape.standard,
      backgroundImage: NetworkImage(imageUrl),
      size: screenHeight / 12,
      backgroundColor: ThemeColor.blackColor,
    );
  }
}
