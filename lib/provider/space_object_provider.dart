import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galactic_scales/model/space_object.dart';

class SpaceObjectProvider extends ChangeNotifier {
  List<SpaceObject> _spaceObjects = [];
  List<SpaceObject> get spaceObjects => _spaceObjects;
  late bool isLoading = false;

  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();
    try {
      final String jsonData = await rootBundle.loadString('assets/data.json');
      final Map<String, dynamic> parsedJson = jsonDecode(jsonData);
      _spaceObjects = parsedJson.values.map((e) => SpaceObject.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
