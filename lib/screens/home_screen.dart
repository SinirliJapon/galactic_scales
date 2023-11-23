import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';
import 'package:galactic_scales/routes/app_router.gr.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<SpaceObjectProvider>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Solar System'))),
      body: Consumer<SpaceObjectProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.spaceObjects.isEmpty) {
            return const Center(child: Text('No Space Object Available'));
          } else {
            return GridView.builder(
              itemCount: value.spaceObjects.length,
              itemBuilder: (context, index) {
                final SpaceObject spaceObject = value.spaceObjects[index];
                return GestureDetector(
                  onTap: () => AutoRouter.of(context).push(SpaceObjectInfoRoute(spaceObjectId: spaceObject.id)),
                  child: Card(
                      elevation: 2,
                      color: Colors.black,
                      margin: const EdgeInsets.all(4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(spaceObject.image, width: screenWidth / 3),
                      )),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            );
          }
        },
      ),
    );
  }
}
