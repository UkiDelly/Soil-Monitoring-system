import 'package:flutter/material.dart';

import '../../../models/enum.dart';

class GardenDetailPlantCard extends StatelessWidget {
  final Plant plant;
  const GardenDetailPlantCard({Key? key, required this.plant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 250,
        child: Column(
          children: [
            Image.asset(enumToPath(plant)),
            Text(
              enumToString(plant).toUpperCase(),
              style: const TextStyle(fontSize: 40),
            )
          ],
        ),
      ),
    );
  }
}
