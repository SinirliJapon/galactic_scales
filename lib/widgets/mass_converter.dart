import 'package:flutter/material.dart';

enum MassUnit { kilograms, pounds, ounces, grams }

class MassConverter extends StatefulWidget {
  final double massInKilograms;

  const MassConverter({Key? key, required this.massInKilograms}) : super(key: key);

  @override
  State<MassConverter> createState() => _MassConverterState();
}

class _MassConverterState extends State<MassConverter> {
  MassUnit _currentUnit = MassUnit.kilograms;

  String formatScientificNotation(double value) {
    final scientific = value.toStringAsExponential(2);
    final parts = scientific.split('e');
    return '${parts[0]} × 10^${int.parse(parts[1])}';
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double massInKilograms = widget.massInKilograms;
    double convertedMass = _convertMass(massInKilograms, _currentUnit);

    return Container(
      width: screenWidth / 2.2,
      height: screenHeight / 12,
      decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 0.3)),
      child: ListTile(
        leading: const Icon(Icons.scale, color: Colors.white),
        title: Text('${formatScientificNotation(convertedMass)} ${_getUnitString()}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
        subtitle: Text('MASS', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: screenHeight / 60)),
        onTap: () {
          setState(() {
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
        },
      ),
    );
  }

  String _getUnitString() {
    switch (_currentUnit) {
      case MassUnit.kilograms:
        return 'kg';
      case MassUnit.pounds:
        return 'lb';
      case MassUnit.ounces:
        return 'oz';
      case MassUnit.grams:
        return 'g';
    }
  }
}
