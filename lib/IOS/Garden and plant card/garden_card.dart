// ignore_for_file: must_be_immutable

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesis/IOS/Gardens%20Page/garden_page.dart';

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
            closedBuilder: (_, openContainer) => _Context(
                  name: widget.name,
                  status: widget.status,
                ),

            //If open
            openBuilder: (_, closeContainer) => const Garden()));
  }
}

class _Context extends StatelessWidget {
  String name;
  String? status;
  _Context({
    Key? key,
    required this.name,
    this.status,
  }) : super(key: key);

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
              child: Text("#$name",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "Readex Pro",
                      fontSize: 50,
                      fontWeight: FontWeight.bold))),

          // status of the garden
          Positioned(
              top: 8,
              right: 10,
              child: status == "good"
                  ? SvgPicture.asset(
                      'assets/check_status.svg',
                      width: 30,
                      color: const Color(0xfffefefe),
                    )
                  : status == "warning"
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

class AddGardenCard extends StatelessWidget {
  const AddGardenCard({Key? key}) : super(key: key);

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
