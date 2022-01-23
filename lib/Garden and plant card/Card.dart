import 'package:flutter/material.dart';
import 'package:thesis/Gardens/Garden%20Page.dart';

class GardenAndPlantCard extends StatefulWidget {
  int? gardenOrPlant;
  GardenAndPlantCard({Key? key, this.gardenOrPlant}) : super(key: key);

  @override
  _GardenAndPlantCardState createState() => _GardenAndPlantCardState();
}

class _GardenAndPlantCardState extends State<GardenAndPlantCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      // Card
      child: GestureDetector(
        onTap: () {
          if (widget.gardenOrPlant == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Garden()),
            );
          } else {}
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: widget.gardenOrPlant == 1
              ? const Color(0xff669D6B)
              : Colors.white,
          child: Container(
            width: 200,
            //child: ,
          ),
        ),
      ),
    );
  }
}
