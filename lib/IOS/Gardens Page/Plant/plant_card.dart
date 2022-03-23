import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/Gardens%20Page/Plant/plant_detail_page.dart';

class PlantCard extends StatefulWidget {
  const PlantCard({Key? key}) : super(key: key);

  @override
  _PlantCardState createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      // Card
      child: OpenContainer(
          transitionDuration: const Duration(milliseconds: 300),
          closedElevation: 5,
          // When the Container is closed
          onClosed: (data) {
            setState(() {});
          },
          openColor: const Color(0xff669D6B),
          //Color when the Container is closed
          closedColor: const Color(0xfffefefe),
          //Shape of the close Container
          closedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          // If close,
          closedBuilder: (_, openContainer) => const _PlantCard(),

          //If open
          openBuilder: (_, closeContainer) => const PlantPage()),
    );
  }
}

class _PlantCard extends StatefulWidget {
  const _PlantCard({Key? key}) : super(key: key);

  @override
  __PlantCardState createState() => __PlantCardState();
}

class __PlantCardState extends State<_PlantCard> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
    );
  }
}
