import 'package:flutter/material.dart';
import 'package:thesis/views/Garden%20Detail/widgets/garden_name.dart';
import 'package:thesis/views/Garden%20Detail/widgets/sensor_display.dart';

class GardenDetail extends StatelessWidget {
  final String gardenName, notes;
  const GardenDetail({Key? key, required this.gardenName, required this.notes})
      : super(key: key);

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
                gardenName: gardenName,
                notes: notes,
                isDarkMode: isDarkMode,
              ),

              //
              const SizedBox(
                height: 10,
              ),

              //* Sensor Data
              SizedBox(
                width: MediaQuery.of(context).size.width - 10,
                height: 700,
                child: const ShowSensorData(),
              ),
              //* Plant

              //* Recommendation
            ],
          ),
        ),
      ),
    );
  }
}
