import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';
import 'package:galactic_scales/widgets/distance_slider.dart';
import 'package:galactic_scales/widgets/space_object_name.dart';
import 'package:galactic_scales/widgets/temperature_converter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SpaceObjectInfoScreen extends StatelessWidget {
  final int spaceObjectId;
  const SpaceObjectInfoScreen({super.key, required this.spaceObjectId});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, foregroundColor: Colors.white),
      backgroundColor: Colors.black,
      body: Consumer<SpaceObjectProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (value.spaceObjects.isEmpty) {
          return const Center(child: Text('No space object available'));
        } else {
          final object = value.spaceObjects[spaceObjectId];
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceObjectName(object),
                Image.network(object.image, height: screenHeight / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TemperatureConverter(surfaceTemperature: object.surfaceTemperature),
                    TemperatureConverter(surfaceTemperature: object.surfaceTemperature),
                  ],
                ),
                const SizedBox(height: 10),
                DistanceSlider(distanceFromSun: object.distanceFromSun),
              ],
            ),
          );
        }
      }),
    );
  }
}

void urlLaunch(String url) {
  final Uri uri = Uri.parse(url);
  try {
    launchUrl(uri);
  } catch (e) {
    rethrow;
  }
}
