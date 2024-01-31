import 'package:flutter/material.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';
import 'package:galactic_scales/utils/descriptions.dart';
import 'package:galactic_scales/widgets/popup_icon_button.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/link_icon_button.dart';
import 'package:provider/provider.dart';

/* This component is represents the space object info screen's appbar*/
class AppbarRow extends StatelessWidget {
  const AppbarRow({super.key, required this.spaceObjectId});

  final int spaceObjectId;

  @override
  Widget build(BuildContext context) {
    return Consumer<SpaceObjectProvider>(builder: (context, value, child) {
      return Row(
        children: [
          LinkIconButton(url: value.spaceObjects[spaceObjectId].url),
          const PopupIconButton(title: Descriptions.infoScreenTitle, description: Descriptions.infoScreenDescription)
        ],
      );
    });
  }
}
