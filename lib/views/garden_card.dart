// ignore_for_file: must_be_immutable

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:thesis/main.dart';

import '../settings/provider.dart';
import 'garden details/garden_page.dart';



class GardenCard extends StatefulWidget {
  String gardenId, gardenName, notes, plant;
  int index;

  GardenCard(
      {Key? key,
      required this.index,
      required this.gardenId,
      required this.gardenName,
      required this.notes,
      required this.plant})
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
            openColor: mainColor,
            //Color when the Container is closed
            closedColor: mainColor,
            //Shape of the close Container
            closedShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            // If close,
            closedBuilder: (_, openContainer) => _contents(),

            //If open
            openBuilder: (_, closeContainer) {
              return Consumer(
                builder: (ctx, ref, child) {
                  final token = ref.watch(tokenProvider);
                  return GardenPage(
                    token: token,
                    gardenId: widget.gardenId,
                    gardenName: widget.gardenName,
                    notes: widget.notes,
                    plant: widget.plant,
                  );
                },
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
