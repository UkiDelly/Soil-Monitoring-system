import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page.dart';
import 'package:animations/animations.dart';
import 'package:thesis/IOS/Gardens/New%20Garden.dart';

class GardenCard extends StatefulWidget {
  const GardenCard({Key? key}) : super(key: key);

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
            transitionDuration: const Duration(seconds: 1),
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
            closedBuilder: (_, openContainer) => _Card(),

            //If open
            openBuilder: (_, closeContainer) => Garden()));
  }
}

// The actuall Garden card widget
class _Card extends StatefulWidget {
  const _Card({Key? key}) : super(key: key);

  @override
  __CardState createState() => __CardState();
}

class __CardState extends State<_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 200,
        child: Stack(
          children: [
            // Name of the garden
            Positioned(
                top: 15,
                left: 17,
                width: 125,
                child: Text("#1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Readex Pro",
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
            Positioned(
              top: 8,
              right: 10,
              child: SizedBox(
                  width: 30,
                  height: 30,
                  // if there is laking, use warning
                  child: SvgPicture.asset(
                    "assets/check.svg",
                    color: Colors.white,
                  )),
            ),

            // comment of the garden
            const Positioned(
                width: 100,
                right: 10,
                top: 70,
                child: Text(
                    "Summary of the status of the soil and comment will be display here!~~"))
          ],
        ),
      ),
    );
  }
}

class AddGarden extends StatelessWidget {
  const AddGarden({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),

        // Card
        child: OpenContainer(
            closedBuilder: (_, openBuilder) => _AddGardenCard(),
            openBuilder: (_, closeBuilder) => NewGardenCard()));
  }
}

class _AddGardenCard extends StatelessWidget {
  const _AddGardenCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
