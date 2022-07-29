import 'package:flutter/material.dart';
import 'package:thesis/views/Garden%20Detail/widgets/garden_name.dart';
import 'package:thesis/views/Garden%20Detail/widgets/plant_card.dart';
import 'package:thesis/views/Garden%20Detail/widgets/sensor_display.dart';

import '../../models/garden.dart';

class GardenDetail extends StatelessWidget {
  final Garden garden;
  const GardenDetail({
    Key? key,
    required this.garden,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // check dark mode is on
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          //
          const Spacer(),

          //* History button
          IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(
                Icons.history,
              )),

          //
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //* Garden Name
              GardenInfo(
                gardenName: garden.name,
                notes: garden.notes,
                isDarkMode: isDarkMode,
              ),

              //
              const SizedBox(
                height: 10,
              ),

              //
              const Divider(),

              //* Sensor Data
              SizedBox(
                width: MediaQuery.of(context).size.width - 10,
                height: 530,
                child: const ShowSensorData(),
              ),

              //
              const SizedBox(
                height: 10,
              ),

              //
              const Divider(),

              //* Plant
              const Text(
                "Plant",
                style: TextStyle(fontSize: 45),
              ),
              GardenDetailPlantCard(plant: garden.plant)

              //* Recommendation
            ],
          ),
        ),
      ),
    );
  }
}
