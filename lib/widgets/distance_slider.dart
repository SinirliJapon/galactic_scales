import 'dart:math';
import 'package:flutter/material.dart';

class DistanceSlider extends StatefulWidget {
  final double distanceFromSun;

  const DistanceSlider({Key? key, required this.distanceFromSun}) : super(key: key);

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
    {"name": "Football Stadium", "property": 100.0},
    {"name": "Formula 1 Monaco", "property": 3300.0},
    {"name": "Golf Area", "property": 6400.0},
    {"name": "Marathon Length", "property": 42195000.0}
  ];

  final List<Map<String, dynamic>> vehicles = [
    {"name": "Mobile Phone", "property": 0.15},
    {"name": "Car", "property": 4.5},
    {"name": "F-14 Falcon", "property": 19.0},
    {"name": "Space-X Falcon", "property": 70.0},
    {"name": "Shinkansken Bullet Train", "property": 400.0}
  ];

  final List<Map<String, dynamic>> animals = [
    {"name": "Ant", "property": 50.0},
    {"name": "Crow", "property": 100.0},
    {"name": "Lion", "property": 3300.0},
    {"name": "Giraffe", "property": 6400.0},
    {"name": "Blue Whale", "property": 42195000.0}
  ];

  int selectedLandmarkIndex = 0;
  String selectedLandmark = '';
  double distanceRatio = 0.0;

  String formatScientificNotation(double value) {
    final scientific = value.toStringAsExponential(2);
    final parts = scientific.split('e');
    return '${parts[0]} × 10^${parts[1].replaceAll('+', '')}';
  }

  @override
  void initState() {
    super.initState();
    selectedLandmark = landmarks[selectedLandmarkIndex]["name"];
    double distanceFromSunInMetric = widget.distanceFromSun * 149.6 * pow(10, 6);
    distanceRatio = distanceFromSunInMetric / landmarks[selectedLandmarkIndex]["property"];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: screenWidth - 20,
        decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 0.3)),
        child: ListTile(
            leading: const Icon(Icons.apartment_outlined, color: Colors.white),
            title: Slider(
              min: 0,
              max: 4,
              divisions: 4,
              label: selectedLandmark,
              value: selectedLandmarkIndex.toDouble(),
              onChanged: (value) {
                setState(() {
                  selectedLandmarkIndex = value.toInt();
                  double distanceFromSunInMetric = widget.distanceFromSun * 149.6 * pow(10, 6);
                  distanceRatio = distanceFromSunInMetric / landmarks[selectedLandmarkIndex]["property"];
                  selectedLandmark = landmarks[selectedLandmarkIndex]["name"];
                });
              },
              activeColor: Colors.purple,
              inactiveColor: Colors.white,
            ),
            trailing: Text(formatScientificNotation(distanceRatio), style: const TextStyle(color: Colors.white))),
      ),
    );
  }
}
