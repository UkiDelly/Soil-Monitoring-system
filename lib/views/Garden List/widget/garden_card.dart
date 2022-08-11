// ignore_for_file: must_be_immutable

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:thesis/main.dart';
import 'package:thesis/provider/garden.dart';
import 'package:thesis/views/Garden%20Detail/garden_page.dart';

import '../../../models/garden.dart';

class GardenCard extends StatefulWidget {
  final String token;
  final Garden garden;

  int index;

  GardenCard(
      {Key? key,
      required this.index,
      required this.token,
      required this.garden})
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
            transitionDuration: const Duration(milliseconds: 1500),
            closedElevation: 5,
            // When the Container is closed
            onClosed: (data) {
              didChangeDependencies();
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
                  // save the garden id
                  ref
                      .watch(gardenIDProvider.notifier)
                      .update((state) => widget.garden.id!);
                  return GardenDetail(
                    garden: widget.garden,
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
          child: Text(widget.garden.name,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
