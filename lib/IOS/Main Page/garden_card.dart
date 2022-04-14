// ignore_for_file: must_be_immutable

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/Gardens%20Page/garden_page.dart';

class GardenCard extends StatefulWidget {
  String gardenId;
  String gardenName;
  int index;
  String notes;

  GardenCard(
      {Key? key,
      required this.index,
      required this.gardenId,
      required this.gardenName,
      required this.notes})
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
            closedBuilder: (_, openContainer) => _contents(),

            //If open
            openBuilder: (_, closeContainer) {
              return
                  // Center(child: Text(widget.gardenID));
                  GardenPage(
                gardenId: widget.gardenId,
                gardenName: widget.gardenName,
              );
            }));
  }

  //* Content of the garden card
  Widget _contents() {
    return SizedBox(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.gardenName,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
