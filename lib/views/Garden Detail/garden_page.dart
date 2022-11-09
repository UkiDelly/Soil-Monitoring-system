import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/models/fertilizer.dart';
import 'package:thesis/models/history.dart';
import 'package:thesis/provider/sensor/sensor_data.dart';
import 'package:thesis/views/Garden%20Detail/widgets/garden_name.dart';
import 'package:thesis/views/Garden%20Detail/widgets/plant_card.dart';
import 'package:thesis/views/Garden%20Detail/widgets/sensor_display.dart';

import '../../models/garden.dart';
import '../History/history_page.dart';

class GardenDetail extends ConsumerWidget {
  final Garden garden;
  const GardenDetail({
    Key? key,
    required this.garden,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensor = ref.watch(sensorDataStateProvider.notifier);

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
              onPressed: () => Navigator.of(context).push(PageTransition(
                  child: HistoryPage(
                      historyData: HistoryOfSensorData(sensorList: sensor.getSensorDataList())),
                  type: PageTransitionType.rightToLeft)),
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
                height: 550,
                child: ShowSensorData(
                    // callback: getSensorDataList,
                    ),
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
              GardenDetailPlantCard(plant: garden.plant),

              //* Recommendation
              FertilizerCards(
                  nAverage: sensor.nAverage,
                  pAverage: sensor.pAverage,
                  kAverage: sensor.kAverage,
                  phAverage: sensor.phAverage,
                  plant: garden.plant)
            ],
          ),
        ),
      ),
    );
  }
}
