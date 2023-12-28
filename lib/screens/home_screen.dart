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
  IconData icon = Icons.grid_off_rounded;
  int grid = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<SpaceObjectProvider>(context, listen: false).fetchData();
    });
  }

  void _toggleGrid() {
    setState(() {
      if (grid == 2) {
        grid = 3;
        icon = Icons.grid_on_rounded;
      } else if (grid == 3) {
        grid = 1;
        icon = Icons.grid_off_rounded;
      } else {
        grid = 2;
        icon = Icons.grid_view_rounded;
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
            IconButton(onPressed: _toggleGrid, icon: Icon(icon)),
            const PopupIconButton(description: Descriptions.homeScreenDescription),
          ],
        ),
        body: Consumer<SpaceObjectProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (value.spaceObjects.isEmpty) {
              return const Center(child: Text('No Space Object Available'));
            } else {
              return grid == 1
                  ? HomeScreenListView(spaceObjects: value.spaceObjects, screenHeight: screenHeight)
                  : HomeScreenGridView(grid: grid, spaceObjects: value.spaceObjects);
            }
          },
        ),
      ),
    );
  }
}

class HomeScreenListView extends StatelessWidget {
  const HomeScreenListView({
    super.key,
    required this.spaceObjects,
    required this.screenHeight,
  });

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
      onTap: () => AutoRouter.of(context).push(SpaceObjectInfoRoute(spaceObjectId: spaceObject.id)),
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
          onTap: () => AutoRouter.of(context).push(SpaceObjectInfoRoute(spaceObjectId: spaceObject.id)),
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
