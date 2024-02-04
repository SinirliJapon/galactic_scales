import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:galactic_scales/routes/app_router.gr.dart';
import 'package:galactic_scales/widgets/home_screen_widgets/home_screen_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

/* This component is home screen's list tile view */
class HomeScreenListTile extends StatelessWidget {
  const HomeScreenListTile({
    super.key,
    required this.context,
    required this.spaceObject,
    required this.spaceObjectNickname,
    required this.screenHeight,
  });

  final BuildContext context;
  final SpaceObject spaceObject;
  final String spaceObjectNickname;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      onTap: () {
        FocusScope.of(context).unfocus();
        AutoRouter.of(context).push(SpaceObjectInfoRoute(spaceObjectId: spaceObject.id));
      },
      avatar: HomeScreenAvatar(imageUrl: spaceObject.image, screenHeight: screenHeight),
      title: Text(spaceObject.name, style: const TextStyle(color: ThemeColor.foregroundColor, fontSize: 20)),
      subTitle: Text(spaceObjectNickname.toUpperCase(), style: const TextStyle(color: ThemeColor.foregroundColor)),
      icon: const Icon(Icons.chevron_right, color: ThemeColor.foregroundColor),
      listItemTextColor: ThemeColor.foregroundColor,
      color: ThemeColor.blackColor,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      margin: const EdgeInsets.all(4),
      radius: 10,
    );
  }
}
