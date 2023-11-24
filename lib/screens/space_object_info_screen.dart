import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';
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
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.network(value.spaceObjects[spaceObjectId].image, height: screenHeight / 2),
                Container(
                  decoration: spaceObjectBoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(value.spaceObjects[spaceObjectId].name, style: spaceObjectTextStyle()),
                        const SizedBox(height: 10),
                        Text(value.spaceObjects[spaceObjectId].description, style: spaceObjectTextStyle()),
                        const SizedBox(height: 10),
                        Text('Distance from Earth: ${value.spaceObjects[spaceObjectId].distanceFromEarth}', style: spaceObjectTextStyle()),
                        const SizedBox(height: 10),
                        Text('Distance from Sun: ${value.spaceObjects[spaceObjectId].distanceFromSun}', style: spaceObjectTextStyle()),
                        const SizedBox(height: 10),
                        Text('ObjectType: ${value.spaceObjects[spaceObjectId].objectType}', style: spaceObjectTextStyle()),
                        const SizedBox(height: 10),
                        Text('Orbits: ${value.spaceObjects[spaceObjectId].orbits}', style: spaceObjectTextStyle()),
                        const SizedBox(height: 10),
                        Text('Surface Temperature: ${value.spaceObjects[spaceObjectId].surfaceTemperature}', style: spaceObjectTextStyle()),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            urlLaunch(value.spaceObjects[spaceObjectId].url);
                          },
                          child: Text('Discover more !', style: spaceObjectTextStyle()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  void urlLaunch(String url) {
    final Uri uri = Uri.parse(url);
    try {
      launchUrl(uri);
    } catch (e) {
      rethrow;
    }
  }

  BoxDecoration spaceObjectBoxDecoration() {
    return const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)), color: Colors.white);
  }

  TextStyle spaceObjectTextStyle() => const TextStyle(fontWeight: FontWeight.w600, fontSize: 18);
}
