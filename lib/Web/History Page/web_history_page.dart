import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thesis/History%20page%20Widgets/humidity_history.dart';
import 'package:thesis/History%20page%20Widgets/moisture_history.dart';
import 'package:thesis/History%20page%20Widgets/npk_history.dart';
import 'package:thesis/History%20page%20Widgets/ph_history.dart';
import 'package:thesis/History%20page%20Widgets/temperature.dart';

class WebHistory extends StatelessWidget {
  WebHistory(
      {Key? key,
      required this.nSpot,
      required this.pSpot,
      required this.kSpot,
      required this.phSpot,
      required this.tempSpot,
      required this.moistureSpot,
      required this.humiditySpot})
      : super(key: key);

  List<FlSpot> nSpot,
      pSpot,
      kSpot,
      phSpot,
      tempSpot,
      moistureSpot,
      humiditySpot;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          //* NPK History
          SizedBox(
              child: NpkHistory(
            width: 400,
            nSpot: nSpot,
            pSpot: pSpot,
            kSpot: kSpot,
          )),

          // pH History
          PhHistory(
            width: 400,
            phSpot: phSpot,
          ),

          // Temperature History
          TempHistory(
            width: 400,
            tempSpot: tempSpot,
          ),

          // Moisture History
          MoistureHistory(
            width: 400,
            moistureSpot: moistureSpot,
          ),

          // Humidity History
          HumidityHistory(
            width: 400,
            humiditySpot: humiditySpot,
          ),
        ],
      ),
    );
  }
}
