import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';
import 'package:galactic_scales/resource/styles.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:galactic_scales/utils/descriptions.dart';
import 'package:galactic_scales/widgets/home_screen_widgets/build_grid_or_list.dart';
import 'package:galactic_scales/widgets/popup_icon_button.dart';
import 'package:galactic_scales/widgets/quiz_screen_widgets/quiz_button.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String searchQuery = '';
  late List<SpaceObject> searchResults = [];
  IconData _icon = Icons.view_list_rounded;
  int _grid = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => Provider.of<SpaceObjectProvider>(context, listen: false).fetchData());
  }

  /* Function related changing the grid view */
  void _toggleGrid() {
    setState(() {
      if (_grid == 2) {
        _grid = 3;
        _icon = Icons.grid_on_rounded;
      } else if (_grid == 3) {
        _grid = 1;
        _icon = Icons.view_list_rounded;
      } else {
        _grid = 2;
        _icon = Icons.grid_view_rounded;
      }
    });
  }

  /* Function related to perform search operation */
  void _performSearch(String value, List<SpaceObject> spaceObjects) {
    setState(() {
      searchQuery = value.toLowerCase();
      searchResults.clear();
      if (searchQuery.isNotEmpty) {
        searchResults.addAll(spaceObjects.where((spaceObject) => spaceObject.name.toLowerCase().startsWith(searchQuery)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: Styles.homeScreenBoxDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: ThemeColor.foregroundColor,
          title: const Text('Galactic Scales', style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            const QuizButton(),
            IconButton(onPressed: _toggleGrid, icon: Icon(_icon)),
            const PopupIconButton(title: Descriptions.homeScreenTitle, description: Descriptions.homeScreenDescription),
          ],
        ),
        body: Consumer<SpaceObjectProvider>(
          builder: (context, object, child) {
            if (object.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (object.spaceObjects.isEmpty) {
              return const Center(child: Text('No Space Object Available'));
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: const TextStyle(color: ThemeColor.foregroundColor),
                      cursorColor: ThemeColor.foregroundColor,
                      onChanged: (value) => _performSearch(value, object.spaceObjects),
                      decoration: Styles.spaceObjectSearchDecoration,
                    ),
                  ),
                  Expanded(
                    child: BuildGridOrList(
                      searchResults: searchResults,
                      searchQuery: searchQuery,
                      grid: _grid,
                      spaceObjects: object.spaceObjects,
                      screenHeight: screenHeight,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
