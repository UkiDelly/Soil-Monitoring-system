// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:animations/animations.dart';
import 'package:thesis/IOS/Gardens/new_garden_page.dart';

class WebGardenCard extends StatefulWidget {
  int indexTapped;
  bool isPressed;
  int? number;
  String status;

  WebGardenCard(
      {Key? key,
      this.number,
      required this.status,
      required this.isPressed,
      required this.indexTapped})
      : super(key: key);

  @override
  _WebGardenCardState createState() => _WebGardenCardState();
}

class _WebGardenCardState extends State<WebGardenCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        // Open Container
        child: AnimatedContainer(
            decoration: BoxDecoration(
                color: widget.isPressed == true &&
                        widget.indexTapped == widget.number
                    ? const Color.fromARGB(255, 47, 73, 50)
                    : const Color(0xff669D6B),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            duration: const Duration(milliseconds: 300),
            child: _WebGardenCard(
              isPressed: widget.isPressed,
              number: widget.number,
              status: "good",
            )));
  }
}

// The actuall Garden card widget
class _WebGardenCard extends StatefulWidget {
  bool isPressed;
  int? number;
  String? status;

  _WebGardenCard(
      {Key? key, this.number, required this.status, required this.isPressed})
      : super(key: key);

  @override
  __WebGardenCardState createState() => __WebGardenCardState();
}

class __WebGardenCardState extends State<_WebGardenCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.isPressed == false ? 300 : 200,
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

class WebAddGarden extends StatefulWidget {
  bool isPressed;
  WebAddGarden({Key? key, required this.isPressed}) : super(key: key);

  @override
  State<WebAddGarden> createState() => _WebAddGardenState();
}

class _WebAddGardenState extends State<WebAddGarden> {
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
            closedBuilder: (_, openBuilder) => _AddWebGardenCard(
                  isPressed: widget.isPressed,
                ),
            openBuilder: (_, closeBuilder) => const AddNewGarden()));
  }
}

class _AddWebGardenCard extends StatefulWidget {
  bool isPressed;
  _AddWebGardenCard({Key? key, required this.isPressed}) : super(key: key);

  @override
  State<_AddWebGardenCard> createState() => _AddWebGardenCardState();
}

class _AddWebGardenCardState extends State<_AddWebGardenCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.isPressed == false ? 300 : 200,
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
