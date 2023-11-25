import 'package:flutter/material.dart';

enum TemperatureUnit { celsius, fahrenheit, kelvin }

class TemperatureConverter extends StatefulWidget {
  final double surfaceTemperature;

  const TemperatureConverter({Key? key, required this.surfaceTemperature}) : super(key: key);

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  TemperatureUnit _currentUnit = TemperatureUnit.celsius;

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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double celsiusTemperature = widget.surfaceTemperature;
    double convertedTemperature = _convertTemperature(celsiusTemperature, _currentUnit);

    return Container(
      width: screenWidth / 2.2,
      height: screenHeight / 12,
      decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 0.3)),
      child: ListTile(
        leading: const Icon(Icons.thermostat, color: Colors.white),
        title: Text('${convertedTemperature.toStringAsFixed(2)} ${_getUnitString()}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
        subtitle: Text('TEMPERATURE', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: screenHeight / 60)),
        onTap: () {
          setState(() {
            if (_currentUnit == TemperatureUnit.celsius) {
              _currentUnit = TemperatureUnit.fahrenheit;
            } else if (_currentUnit == TemperatureUnit.fahrenheit) {
              _currentUnit = TemperatureUnit.kelvin;
            } else {
              _currentUnit = TemperatureUnit.celsius;
            }
          });
        },
      ),
    );
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
