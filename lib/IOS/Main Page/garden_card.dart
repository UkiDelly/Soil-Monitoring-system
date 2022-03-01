// ignore_for_file: must_be_immutable

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../Gardens Page/garden_page.dart';
import '../New Garden Page/new_garden_page.dart';

class GardenCard extends StatefulWidget {
  String name;
  String status;
  GardenCard({Key? key, required this.name, required this.status})
      : super(key: key);

  @override
  _GardenCardState createState() => _GardenCardState();
}

class _GardenCardState extends State<GardenCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        // Open Container
        child: OpenContainer(
            transitionDuration: const Duration(milliseconds: 300),
            closedElevation: 5,
            // When the Container is closed
            onClosed: (data) {
              setState(() {});
            },
            openColor: const Color(0xff669D6B),
            //Color when the Container is closed
            closedColor: const Color(0xff669D6B),
            //Shape of the close Container
            closedShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            // If close,
            closedBuilder: (_, openContainer) => _Contents(name: widget.name),

            //If open
            openBuilder: (_, closeContainer) {
              return const Garden();
            }));
  }
}

//* Content of the garden card
class _Contents extends StatelessWidget {
  String name;

  _Contents({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            child: Text(name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Readex Pro",
                    fontSize: 50,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class AddGarden extends StatefulWidget {
  const AddGarden({Key? key}) : super(key: key);

  @override
  State<AddGarden> createState() => _AddGardenState();
}

class _AddGardenState extends State<AddGarden> {
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
            openColor: const Color(0xfffefefe),
            //Color when the Container is closed
            closedColor: const Color(0xfffefefe),
            //Shape of the close Container
            closedShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            closedBuilder: (_, openBuilder) => const _AddGardenCard(),
            openBuilder: (_, closeBuilder) => const AddNewGarden()));
  }
}

class _AddGardenCard extends StatelessWidget {
  const _AddGardenCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.add,
            color: Colors.grey,
            size: 70,
          ),
          Text(
            "Add New Garden",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
