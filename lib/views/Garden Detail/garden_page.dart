import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/models/fertilizer.dart';
import 'package:thesis/models/history.dart';
import 'package:thesis/models/sensor_data.dart';

import 'package:thesis/views/Garden%20Detail/widgets/garden_name.dart';
import 'package:thesis/views/Garden%20Detail/widgets/plant_card.dart';
import 'package:thesis/views/Garden%20Detail/widgets/sensor_display.dart';

import '../../models/garden.dart';
import '../History/history_page.dart';

class GardenDetail extends StatefulWidget {
  final Garden garden;
  const GardenDetail({
    Key? key,
    required this.garden,
  }) : super(key: key);

  @override
  State<GardenDetail> createState() => _GardenDetailState();
}

class _GardenDetailState extends State<GardenDetail> {
  List<Datum> sensorDataList = [];
  List<Datum> lastSensorData = [];

  double nAverage = 0, pAverage = 0, kAverage = 0, phAverage = 0;

  // callBack
  getSensorDataList(List<Datum> sensorDataList, List<Datum> lastSensorData) {
    // get the average..
    for (Datum date in lastSensorData) {
      nAverage += date.nitrogen;
      pAverage += date.phosphorous;
      kAverage += date.potassium;
      phAverage += date.pH;
    }

    setState(() {
      // get the average
      nAverage /= nAverage;
      pAverage /= pAverage;
      kAverage /= kAverage;
      phAverage /= phAverage;

      this.sensorDataList = sensorDataList;
      this.lastSensorData = lastSensorData;
    });
  }

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
              onPressed: () => Navigator.of(context).push(PageTransition(
                  child: HistoryPage(
                      historyData:
                          HistoryOfSensorData(sensorList: sensorDataList)),
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
                gardenName: widget.garden.name,
                notes: widget.garden.notes,
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
                  callback: getSensorDataList,
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
              GardenDetailPlantCard(plant: widget.garden.plant),

              //* Recommendation
              FertilizerCards(
                  nAverage: nAverage,
                  pAverage: pAverage,
                  kAverage: kAverage,
                  phAverage: phAverage,
                  plant: widget.garden.plant)
            ],
          ),
        ),
      ),
    );
  }
}
