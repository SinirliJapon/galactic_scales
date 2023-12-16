import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:galactic_scales/widgets/distance_slider.dart';
import 'package:galactic_scales/widgets/link_icon_button.dart';
import 'package:galactic_scales/widgets/mass_converter.dart';
import 'package:galactic_scales/widgets/popup_icon_button.dart';
import 'package:galactic_scales/widgets/space_object_image.dart';
import 'package:galactic_scales/widgets/space_object_name.dart';
import 'package:galactic_scales/widgets/temperature_converter.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SpaceObjectInfoScreen extends StatelessWidget {
  final int spaceObjectId;
  const SpaceObjectInfoScreen({super.key, required this.spaceObjectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.blackColor,
        foregroundColor: ThemeColor.foregroundColor,
        actions: [AppbarRow(spaceObjectId: spaceObjectId)],
      ),
      backgroundColor: ThemeColor.blackColor,
      body: Consumer<SpaceObjectProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (value.spaceObjects.isEmpty) {
          return const Center(child: Text('No space object available'));
        } else {
          final object = value.spaceObjects[spaceObjectId];
          return SpaceObjectScreenWidget(object: object);
        }
      }),
    );
  }
}

class AppbarRow extends StatelessWidget {
  const AppbarRow({super.key, required this.spaceObjectId});

  final int spaceObjectId;

  @override
  Widget build(BuildContext context) {
    return Consumer<SpaceObjectProvider>(builder: (context, value, child) {
      return Row(
        children: [
          LinkIconButton(url: value.spaceObjects[spaceObjectId].url),
          PopupIconButton(description: value.spaceObjects[spaceObjectId].description),
        ],
      );
    });
  }
}

class SpaceObjectScreenWidget extends StatelessWidget {
  const SpaceObjectScreenWidget({super.key, required this.object});

  final SpaceObject object;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double distance = (object.id == 0 || object.id == 10) ? object.distanceFromEarth : object.distanceFromSun;
    final description = (object.id == 0 || object.id == 10) ? 'Distance from Earth' : 'Distance from Sun';
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceObjectName(object),
          SpaceObjectImage(object: object, screenHeight: screenHeight),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TemperatureConverter(surfaceTemperature: object.surfaceTemperature),
            MassConverter(massInKilograms: object.mass),
          ]),
          const SizedBox(height: 10),
          DistanceSlider(distance: distance, description: description),
          const SizedBox(height: 10),
          DistanceSlider(distance: distance, description: description),
        ],
      ),
    );
  }
}
