import 'dart:math';
import 'package:flutter/material.dart';
import 'package:galactic_scales/resource/theme_color.dart';

class DistanceSlider extends StatefulWidget {
  final double distance;
  final String description;

  const DistanceSlider({Key? key, required this.distance, required this.description}) : super(key: key);

  @override
  State<DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  final List<Map<String, dynamic>> landmarks = [
    {"name": "Little Mermaid Statue", "property": 1.25},
    {"name": "Taj Mahal", "property": 73.0},
    {"name": "Eiffel Tower", "property": 330.0},
    {"name": "Burj Khalifa", "property": 830.0},
    {"name": "Great Wall of China", "property": 21196.0}
  ];

  final List<Map<String, dynamic>> naturalWonders = [
    {"name": "Victoria Falls", "property": 1700.0},
    {"name": "Mount Everest", "property": 8800.0},
    {"name": "Grand Canyon", "property": 446000.0},
    {"name": "The Great Barrier Reef", "property": 2300000.0},
    {"name": "Amazon River", "property": 6575000.0}
  ];

  final List<Map<String, dynamic>> sports = [
    {"name": "Olympic Swimming Pool", "property": 50.0},
    {"name": "Football Stadium", "property": 105.0},
    {"name": "Formula 1 Monaco", "property": 3337.0},
    {"name": "Golf Area", "property": 6800.0},
    {"name": "Marathon Length", "property": 42195.0}
  ];

  final List<Map<String, dynamic>> vehicles = [
    {"name": "Mobile Phone", "property": 0.13},
    {"name": "Car", "property": 4.5},
    {"name": "F-14 Tomcat", "property": 19.0},
    {"name": "Space-X Falcon", "property": 70.0},
    {"name": "Shinkansen Bullet Train", "property": 400.0}
  ];

  final List<Map<String, dynamic>> animals = [
    {"name": "Ant", "property": 0.001},
    {"name": "Crow", "property": 0.5},
    {"name": "Lion", "property": 2.5},
    {"name": "Giraffe", "property": 5.5},
    {"name": "Blue Whale", "property": 30.0}
  ];

  int selectedListIndex = 0;
  String selectedListName = '';
  double distanceRatio = 0.0;
  List<Map<String, dynamic>> selectedList = [];

  formatScientificNotation(double value) {
    final scientific = value.toStringAsExponential(2);
    final parts = scientific.split('e');
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('${parts[0]} × 10^${parts[1].replaceAll('+', '')}', style: const TextStyle(fontSize: 16)),
      Text('TIMES', style: TextStyle(fontSize: 14, color: ThemeColor.spaceObjectBoxColor.withOpacity(0.5))),
    ]);
  }

  @override
  void initState() {
    super.initState();
    selectedListName = animals[selectedListIndex]["name"];
    double distanceInMetric = widget.distance * 149.6 * pow(10, 6);
    distanceRatio = distanceInMetric / animals[selectedListIndex]["property"];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: ThemeColor.spaceObjectBoxColor, width: 0.3)),
        child: Column(
          children: [
            ListTile(
              iconColor: ThemeColor.spaceObjectBoxColor,
              leadingAndTrailingTextStyle: const TextStyle(color: ThemeColor.spaceObjectBoxColor),
              titleTextStyle: const TextStyle(color: ThemeColor.spaceObjectBoxColor, fontSize: 20),
              subtitleTextStyle: TextStyle(color: ThemeColor.spaceObjectBoxColor.withOpacity(0.5), fontSize: 16),
              leading: const Icon(Icons.apartment_outlined),
              trailing: formatScientificNotation(distanceRatio),
              title: Text(selectedListName),
              subtitle: Text(widget.description.toUpperCase()),
            ),
            Slider(
              min: 0,
              max: 4,
              divisions: 4,
              value: selectedListIndex.toDouble(),
              activeColor: ThemeColor.sliderActiveColor,
              inactiveColor: ThemeColor.sliderInactiveColor,
              onChanged: (value) {
                setState(() {
                  selectedListIndex = value.toInt();
                  double distanceInMetric = widget.distance * 149.6 * pow(10, 6);
                  distanceRatio = distanceInMetric / animals[selectedListIndex]["property"];
                  selectedListName = animals[selectedListIndex]["name"];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
