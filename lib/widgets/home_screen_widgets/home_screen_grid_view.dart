import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/routes/app_router.gr.dart';

/* This component is home screen's grid view */
class HomeScreenGridView extends StatelessWidget {
  const HomeScreenGridView({
    super.key,
    required this.grid,
    required this.spaceObjects,
  });

  final int grid;
  final List<SpaceObject> spaceObjects;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: spaceObjects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: grid),
      itemBuilder: (context, index) {
        final SpaceObject spaceObject = spaceObjects[index];
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            AutoRouter.of(context).push(SpaceObjectInfoRoute(spaceObjectId: spaceObject.id));
          },
          child: Card(
            elevation: 2,
            color: Colors.black,
            margin: const EdgeInsets.all(4.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(padding: const EdgeInsets.all(4.0), child: Image.network(spaceObject.image)),
          ),
        );
      },
    );
  }
}
