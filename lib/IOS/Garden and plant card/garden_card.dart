// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:animations/animations.dart';
import 'package:thesis/IOS/Gardens%20Page/garden_page.dart';

import '../New Garden Page/new_garden_page.dart';

class GardenCard extends StatefulWidget {
  int? number;
  String status;
  GardenCard({Key? key, this.number, required this.status}) : super(key: key);

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
            closedBuilder: (_, openContainer) => _GardenCard(
                  number: widget.number,
                  status: widget.status,
                ),

            //If open
            openBuilder: (_, closeContainer) => const Garden()));
  }
}

// The actuall Garden card widget
class _GardenCard extends StatefulWidget {
  int? number;
  String? status;
  _GardenCard({Key? key, this.number, required this.status}) : super(key: key);

  @override
  __GardenCardState createState() => __GardenCardState();
}

class __GardenCardState extends State<_GardenCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          // Name of the garden
          Positioned(
              top: 15,
              left: 17,
              width: 125,
              child: Text("#${widget.number}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "Readex Pro",
                      fontSize: 50,
                      fontWeight: FontWeight.bold))),

          // status of the garden
          Positioned(
              top: 8,
              right: 10,
              child: widget.status == "good"
                  ? SvgPicture.asset(
                      'assets/check_status.svg',
                      width: 30,
                      color: const Color(0xfffefefe),
                    )
                  : widget.status == "warning"
                      ? SvgPicture.asset('assets/warning.svg',
                          width: 30, color: Colors.yellow)
                      : SvgPicture.asset(
                          'assets/warning.svg',
                          width: 30,
                          color: Colors.red,
                        )),

          // comment of the garden
          const Positioned(
              width: 100,
              right: 10,
              top: 70,
              child: Text(
                  "Summary of the status of the soil and comment will be display here!~~"))
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
