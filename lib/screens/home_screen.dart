import 'package:flutter/material.dart';
import 'package:galactic_scales/model/space_object.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';

class HomeScreen extends StatelessWidget {
  final SpaceObjectProvider spaceObjectProvider;

  const HomeScreen({Key? key, required this.spaceObjectProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Solar System'))),
      body: FutureBuilder<void>(
        future: spaceObjectProvider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.builder(
              itemCount: spaceObjectProvider.spaceObjects.length,
              itemBuilder: (context, index) {
                final SpaceObject spaceObject = spaceObjectProvider.spaceObjects[index];
                return Card(
                    elevation: 2,
                    color: Colors.black,
                    margin: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Image.network(spaceObject.image, width: screenWidth / 3),
                        SizedBox(height: screenHeight / 55),
                        Text(spaceObject.name.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                      ],
                    ));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            );
          }
        },
      ),
    );
  }
}
