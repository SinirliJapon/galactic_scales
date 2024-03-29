import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:galactic_scales/utils/functions.dart';
import 'package:galactic_scales/utils/slider_list.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/appbar_row.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/distance_slider.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/mass_converter.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/space_object_image.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/space_object_name.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/space_object_orbits.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/space_object_size.dart';
import 'package:galactic_scales/widgets/space_object_info_widgets/temperature_converter.dart';
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
          return SpaceObjectContainer(object: object);
        }
      }),
    );
  }
}

class SpaceObjectContainer extends StatelessWidget {
  const SpaceObjectContainer({super.key, required this.object});

  final SpaceObject object;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceObjectName(object),
          SpaceObjectImage(object: object),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TemperatureConverter(surfaceTemperature: object.surfaceTemperature),
            MassConverter(massInKilograms: object.mass),
          ]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SpaceObjectSize(object),
            SpaceObjectOrbits(object),
          ]),
          CarouselSlider(
            options: CarouselOptions(
              height: screenHeight / 5,
              aspectRatio: 1.0,
              viewportFraction: 1.0,
              reverse: true,
              scrollDirection: Axis.horizontal,
            ),
            items: [
              DistanceSlider(
                  distance: Functions.getSliderDistance(object),
                  description: Functions.getSliderDescription(object),
                  itemList: landmarks,
                  icon: Icons.apartment,
                  name: 'LANDMARKS'),
              DistanceSlider(
                  distance: Functions.getSliderDistance(object),
                  description: Functions.getSliderDescription(object),
                  itemList: animals,
                  icon: Icons.pets,
                  name: 'ANIMALS'),
              DistanceSlider(
                  distance: Functions.getSliderDistance(object),
                  description: Functions.getSliderDescription(object),
                  itemList: naturalWonders,
                  icon: Icons.landscape,
                  name: 'NATURAL WONDERS'),
              DistanceSlider(
                  distance: Functions.getSliderDistance(object),
                  description: Functions.getSliderDescription(object),
                  itemList: sports,
                  icon: Icons.pool,
                  name: 'SPORTS'),
              DistanceSlider(
                  distance: Functions.getSliderDistance(object),
                  description: Functions.getSliderDescription(object),
                  itemList: vehicles,
                  icon: Icons.rocket,
                  name: 'VEHICLES & DEVICES'),
            ],
          ),
        ],
      ),
    );
  }
}
