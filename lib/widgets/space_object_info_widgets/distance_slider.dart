import 'dart:math';
import 'package:flutter/material.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:galactic_scales/utils/functions.dart';

/*  This component represents a slider for visualizing and comparing the distance of a space object in different units or scales. */
class DistanceSlider extends StatefulWidget {
  final double distance;
  final String description;
  final List<Map<String, dynamic>> itemList;
  final IconData icon;
  final String name;

  const DistanceSlider({
    Key? key,
    required this.distance,
    required this.description,
    required this.itemList,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  State<DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  late int selectedListIndex;
  late String selectedListName;
  late double distanceRatio;
  late List<Map<String, dynamic>> selectedList;

  @override
  void initState() {
    super.initState();
    selectedList = widget.itemList;
    selectedListIndex = 0;
    selectedListName = selectedList[selectedListIndex]["name"];
    double distanceInMetric = widget.distance * 149.6 * pow(10, 9);
    distanceRatio = distanceInMetric / selectedList[selectedListIndex]["property"];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: ThemeColor.spaceObjectBoxColor, width: 0.3)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              iconColor: ThemeColor.spaceObjectBoxColor,
              leadingAndTrailingTextStyle: const TextStyle(color: ThemeColor.spaceObjectBoxColor),
              titleTextStyle: const TextStyle(color: ThemeColor.spaceObjectBoxColor, fontSize: 18),
              subtitleTextStyle: TextStyle(color: ThemeColor.spaceObjectBoxColor.withOpacity(0.5), fontSize: 16),
              leading: Icon(widget.icon),
              trailing: Functions.calculateScinetificDistance(distanceRatio),
              title: Text(selectedListName),
              subtitle: Text(widget.description.toUpperCase()),
            ),
            Row(
              children: [
                const Expanded(flex: 1, child: Icon(Icons.arrow_left, color: ThemeColor.spaceObjectBoxColor)),
                Expanded(
                  flex: 8,
                  child: Slider(
                    min: 0,
                    max: (selectedList.length - 1).toDouble(),
                    divisions: selectedList.length - 1,
                    value: selectedListIndex.toDouble(),
                    activeColor: ThemeColor.sliderActiveColor,
                    inactiveColor: ThemeColor.sliderInactiveColor,
                    onChanged: (value) {
                      setState(() {
                        selectedListIndex = value.toInt();
                        double distanceInMetric = widget.distance * 149.6 * pow(10, 6);
                        distanceRatio = distanceInMetric / selectedList[selectedListIndex]["property"];
                        selectedListName = selectedList[selectedListIndex]["name"];
                      });
                    },
                  ),
                ),
                const Expanded(flex: 1, child: Icon(Icons.arrow_right, color: ThemeColor.spaceObjectBoxColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DistanceTrailing extends StatelessWidget {
  final List<String> parts;

  const DistanceTrailing({super.key, required this.parts});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${parts[0]} × 10^${parts[1].replaceAll('+', '')}', style: const TextStyle(fontSize: 16)),
        Text('TIMES', style: TextStyle(fontSize: 14, color: ThemeColor.spaceObjectBoxColor.withOpacity(0.5))),
      ],
    );
  }
}
