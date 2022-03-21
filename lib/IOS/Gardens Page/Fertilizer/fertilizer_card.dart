import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'fettilizer_page.dart';

class FertilizerCard extends StatefulWidget {
  const FertilizerCard({Key? key}) : super(key: key);

  @override
  _FertilizerCardState createState() => _FertilizerCardState();
}

class _FertilizerCardState extends State<FertilizerCard> {
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
          closedBuilder: (_, openContainer) => const _FertilizerCard(),

          //If open
          openBuilder: (_, closeContainer) => const FertilizerPage()),
    );
  }
}

class _FertilizerCard extends StatefulWidget {
  const _FertilizerCard({Key? key}) : super(key: key);

  @override
  __FertilizerCardState createState() => __FertilizerCardState();
}

class __FertilizerCardState extends State<_FertilizerCard> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
    );
  }
}
