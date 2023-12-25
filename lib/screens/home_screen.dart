import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';
import 'package:galactic_scales/routes/app_router.gr.dart';
import 'package:provider/provider.dart';

@immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  IconData icon = Icons.grid_view_rounded;
  int grid = 2;

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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solar System'),
        actions: [const QuizButton(), IconButton(onPressed: _toggleGrid, icon: Icon(icon))],
      ),
      body: Consumer<SpaceObjectProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.spaceObjects.isEmpty) {
            return const Center(child: Text('No Space Object Available'));
          } else {
            return GridView.builder(
              itemCount: value.spaceObjects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: grid),
              itemBuilder: (context, index) {
                final SpaceObject spaceObject = value.spaceObjects[index];
                return GestureDetector(
                  onTap: () => AutoRouter.of(context).push(SpaceObjectInfoRoute(spaceObjectId: spaceObject.id)),
                  child: Card(
                    elevation: 2,
                    color: Colors.black,
                    margin: const EdgeInsets.all(4.0),
                    child: Padding(padding: const EdgeInsets.all(8.0), child: Image.network(spaceObject.image, width: screenWidth / grid)),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class QuizButton extends StatelessWidget {
  const QuizButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        AutoRouter.of(context).push(const QuizRoute());
      },
      icon: const Icon(Icons.quiz),
    );
  }
}
