import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/widgets/home_screen_widgets/home_screen_grid_view.dart';
import 'package:galactic_scales/widgets/home_screen_widgets/home_screen_list_view.dart';

/* This component designed to dynamically switch between a grid view and a list view of space objects */
class BuildGridOrList extends StatelessWidget {
  const BuildGridOrList({
    Key? key,
    required this.searchResults,
    required this.searchQuery,
    required this.grid,
    required this.spaceObjects,
    required this.screenHeight,
  }) : super(key: key);

  final List<SpaceObject> searchResults;
  final String searchQuery;
  final int grid;
  final List<SpaceObject> spaceObjects;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    if (searchResults.isEmpty && searchQuery.isNotEmpty) {
      return const Center(child: Text('No Matching Results Found'));
    } else {
      return grid == 1
          ? HomeScreenListView(spaceObjects: searchResults.isEmpty ? spaceObjects : searchResults, screenHeight: screenHeight)
          : HomeScreenGridView(grid: grid, spaceObjects: searchResults.isEmpty ? spaceObjects : searchResults);
    }
  }
}
