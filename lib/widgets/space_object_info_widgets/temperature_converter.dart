import 'package:flutter/material.dart';
import 'package:galactic_scales/resource/theme_color.dart';

enum TemperatureUnit { celsius, fahrenheit, kelvin }

class TemperatureConverter extends StatefulWidget {
  final double surfaceTemperature;

  const TemperatureConverter({Key? key, required this.surfaceTemperature}) : super(key: key);

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  TemperatureUnit _currentUnit = TemperatureUnit.celsius;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double celsiusTemperature = widget.surfaceTemperature;
    double convertedTemperature = _convertTemperature(celsiusTemperature, _currentUnit);

    return Container(
      width: screenWidth / 2.2,
      height: screenHeight / 12,
      decoration: BoxDecoration(border: Border.all(color: ThemeColor.spaceObjectBoxColor, width: 0.3)),
      child: ListTile(
        iconColor: ThemeColor.spaceObjectBoxColor,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        subtitleTextStyle: TextStyle(color: ThemeColor.spaceObjectBoxColor.withOpacity(0.5), fontSize: screenHeight / 60),
        leading: const Icon(Icons.thermostat),
        title: Text('${convertedTemperature.toStringAsFixed(2)} ${_getUnitString()}'),
        subtitle: const Text('TEMPERATURE'),
        onTap: () {
          switchUnit();
        },
      ),
    );
  }

  void switchUnit() {
    return setState(() {
      if (_currentUnit == TemperatureUnit.celsius) {
        _currentUnit = TemperatureUnit.fahrenheit;
      } else if (_currentUnit == TemperatureUnit.fahrenheit) {
        _currentUnit = TemperatureUnit.kelvin;
      } else {
        _currentUnit = TemperatureUnit.celsius;
      }
    });
  }

  double _convertTemperature(double celsius, TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.celsius:
        return celsius;
      case TemperatureUnit.fahrenheit:
        return (celsius * 9 / 5) + 32;
      case TemperatureUnit.kelvin:
        return celsius + 273.15;
    }
  }

  String _getUnitString() {
    switch (_currentUnit) {
      case TemperatureUnit.celsius:
        return '°C';
      case TemperatureUnit.fahrenheit:
        return '°F';
      case TemperatureUnit.kelvin:
        return 'K';
    }
  }
}
