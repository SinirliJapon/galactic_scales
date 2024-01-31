import 'package:flutter/material.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:galactic_scales/utils/functions.dart';

enum MassUnit { kilograms, pounds, ounces, grams }

class MassConverter extends StatefulWidget {
  final double massInKilograms;

  const MassConverter({Key? key, required this.massInKilograms}) : super(key: key);

  @override
  State<MassConverter> createState() => _MassConverterState();
}

class _MassConverterState extends State<MassConverter> {
  MassUnit _currentUnit = MassUnit.kilograms;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double massInKilograms = widget.massInKilograms;
    double convertedMass = _convertMass(massInKilograms, _currentUnit);

    return Container(
      width: screenWidth / 2.2,
      height: screenHeight / 12,
      decoration: BoxDecoration(border: Border.all(color: ThemeColor.spaceObjectBoxColor, width: 0.3)),
      child: ListTile(
        isThreeLine: false,
        iconColor: ThemeColor.spaceObjectBoxColor,
        titleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ThemeColor.spaceObjectBoxColor),
        subtitleTextStyle: TextStyle(color: ThemeColor.spaceObjectBoxColor.withOpacity(0.5), fontSize: screenHeight / 60),
        leading: const Icon(Icons.scale),
        title: Text('${Functions.scientificMass(convertedMass)} '),
        subtitle: Text('MASS IN ${_getUnitString()}'),
        onTap: () => switchUnit(),
      ),
    );
  }

  void switchUnit() {
    return setState(() {
      if (_currentUnit == MassUnit.kilograms) {
        _currentUnit = MassUnit.pounds;
      } else if (_currentUnit == MassUnit.pounds) {
        _currentUnit = MassUnit.ounces;
      } else if (_currentUnit == MassUnit.ounces) {
        _currentUnit = MassUnit.grams;
      } else {
        _currentUnit = MassUnit.kilograms;
      }
    });
  }

  double _convertMass(double kilograms, MassUnit unit) {
    switch (unit) {
      case MassUnit.kilograms:
        return kilograms;
      case MassUnit.pounds:
        return kilograms * 2.20462;
      case MassUnit.ounces:
        return kilograms * 35.274;
      case MassUnit.grams:
        return kilograms * 1000;
    }
  }

  String _getUnitString() {
    switch (_currentUnit) {
      case MassUnit.kilograms:
        return 'KG';
      case MassUnit.pounds:
        return 'LB';
      case MassUnit.ounces:
        return 'OZ';
      case MassUnit.grams:
        return 'G';
    }
  }
}
