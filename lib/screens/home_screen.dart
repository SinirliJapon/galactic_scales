import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';
import 'package:galactic_scales/resource/styles.dart';
import 'package:galactic_scales/resource/theme_color.dart';
import 'package:galactic_scales/routes/app_router.gr.dart';
import 'package:galactic_scales/utils/descriptions.dart';
import 'package:galactic_scales/widgets/popup_icon_button.dart';
import 'package:galactic_scales/widgets/quiz_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  IconData _icon = Icons.view_list_rounded;
  int _grid = 1;

  late String searchQuery = '';
  late List<SpaceObject> searchResults = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => Provider.of<SpaceObjectProvider>(context, listen: false).fetchData());
  }

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
            const PopupIconButton(description: Descriptions.homeScreenDescription),
          ],
        ),
        body: Expanded(
          child: Consumer<SpaceObjectProvider>(
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
      ),
    );
  }
}

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

class HomeScreenListView extends StatelessWidget {
  const HomeScreenListView({super.key, required this.spaceObjects, required this.screenHeight});

  final List<SpaceObject> spaceObjects;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: spaceObjects.length,
      itemBuilder: (context, index) {
        final SpaceObject spaceObject = spaceObjects[index];
        final String spaceObjectNickname = spaceObject.nickname.isEmpty ? spaceObject.objectType : spaceObject.nickname;
        return HomeScreenListTile(context: context, spaceObject: spaceObject, spaceObjectNickname: spaceObjectNickname, screenHeight: screenHeight);
      },
    );
  }
}

class HomeScreenListTile extends StatelessWidget {
  const HomeScreenListTile({
    super.key,
    required this.context,
    required this.spaceObject,
    required this.spaceObjectNickname,
    required this.screenHeight,
  });

  final BuildContext context;
  final SpaceObject spaceObject;
  final String spaceObjectNickname;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      onTap: () {
        FocusScope.of(context).unfocus();
        AutoRouter.of(context).push(SpaceObjectInfoRoute(spaceObjectId: spaceObject.id));
      },
      avatar: HomeScreenAvatar(imageUrl: spaceObject.image, screenHeight: screenHeight),
      title: Text(spaceObject.name, style: const TextStyle(color: ThemeColor.foregroundColor, fontSize: 20)),
      subTitle: Text(spaceObjectNickname, style: const TextStyle(color: ThemeColor.foregroundColor)),
      icon: const Icon(Icons.chevron_right, color: ThemeColor.foregroundColor),
      listItemTextColor: ThemeColor.foregroundColor,
      color: ThemeColor.blackColor,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      margin: const EdgeInsets.all(4),
      radius: 10,
    );
  }
}

class HomeScreenAvatar extends StatelessWidget {
  const HomeScreenAvatar({
    super.key,
    required this.imageUrl,
    required this.screenHeight,
  });

  final String imageUrl;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return GFAvatar(
      shape: GFAvatarShape.standard,
      backgroundImage: NetworkImage(imageUrl),
      size: screenHeight / 12,
      backgroundColor: ThemeColor.blackColor,
    );
  }
}

class HomeScreenGridView extends StatelessWidget {
  const HomeScreenGridView({
    super.key,
    required this.grid,
    required this.spaceObjects,
  });

  final int grid;
  final List<SpaceObject> spaceObjects;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: spaceObjects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: grid),
      itemBuilder: (context, index) {
        final SpaceObject spaceObject = spaceObjects[index];
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            AutoRouter.of(context).push(SpaceObjectInfoRoute(spaceObjectId: spaceObject.id));
          },
          child: Card(
            elevation: 2,
            color: Colors.black,
            margin: const EdgeInsets.all(4.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(padding: const EdgeInsets.all(4.0), child: Image.network(spaceObject.image)),
          ),
        );
      },
    );
  }
}
