import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/widgets/home_screen_widgets/home_screen_list_tile.dart';

/* This component represents a list view of space objects */
class HomeScreenListView extends StatelessWidget {
  const HomeScreenListView({super.key, required this.spaceObjects, required this.screenHeight});

  final List<SpaceObject> spaceObjects;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: spaceObjects.length,
      itemBuilder: (context, index) {
        final SpaceObject spaceObject = spaceObjects[index];
        final String spaceObjectNickname = spaceObject.nickname.isEmpty ? spaceObject.objectType : spaceObject.nickname;
        return HomeScreenListTile(context: context, spaceObject: spaceObject, spaceObjectNickname: spaceObjectNickname, screenHeight: screenHeight);
      },
    );
  }
}
