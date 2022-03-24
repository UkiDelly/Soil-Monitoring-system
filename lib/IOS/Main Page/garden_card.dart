// ignore_for_file: must_be_immutable

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/Gardens%20Page/garden_page.dart';

class GardenCard extends StatefulWidget {
  String gardenID;
  String gardenName;
  int index;
  GardenCard(
      {Key? key,
      required this.index,
      required this.gardenID,
      required this.gardenName})
      : super(key: key);

  @override
  _GardenCardState createState() => _GardenCardState();
}

class _GardenCardState extends State<GardenCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            closedBuilder: (_, openContainer) =>
                _Contents(name: widget.gardenName, index: widget.index),

            //If open
            openBuilder: (_, closeContainer) {
              return GardenPage(
                gardenID: widget.gardenID,
                gardenName: widget.gardenName,
              ); //Garden();
            }));
  }
}

//* Content of the garden card
class _Contents extends StatelessWidget {
  String name;
  int index;

  _Contents({
    Key? key,
    required this.name,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: Text(
              "#$index",
              style: const TextStyle(fontSize: 30),
            ),
          ),
          Center(
            child: Text(name,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
