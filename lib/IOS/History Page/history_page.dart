import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/Main/provider.dart';

import '../../History page Widgets/humidity_history.dart';
import '../../History page Widgets/moisture_history.dart';
import '../../History page Widgets/npk_history.dart';
import '../../History page Widgets/ph_history.dart';
import '../../History page Widgets/temperature.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff669D6B),
        appBar: AppBar(
          backgroundColor: const Color(0xff669D6B),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            "Soil Status History",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Consumer(
          builder: (ctx, ref, child) {
            final sensorDataList = ref.watch(sensorDataProvider);

            return _History(
              sensorData: sensorDataList,
            );
          },
        ));
  }
}

// ignore: must_be_immutable
class _History extends StatefulWidget {
  List sensorData;
  _History({Key? key, required this.sensorData}) : super(key: key);

  @override
  State<_History> createState() => __HistoryState();
}

class __HistoryState extends State<_History> {
  //* Get sensor data
  List<FlSpot> nSpot = [],
      pSpot = [],
      kSpot = [],
      phSpot = [],
      tempSpot = [],
      moistureSpot = [],
      humiditySpot = [];

  //TODO: create sensor data history
  getSensorData() {
    for (int i = 0; i < 7; i++) {
      // get each sensor data and covert into a spot
      nSpot.add(FlSpot(
          (i + 1).toDouble(), widget.sensorData[i]['nitrogen'].toDouble()));
      pSpot.add(FlSpot(
          (i + 1).toDouble(), widget.sensorData[i]['phosphorous'].toDouble()));
      kSpot.add(FlSpot(
          (i + 1).toDouble(), widget.sensorData[i]['potassium'].toDouble()));
      phSpot.add(
          FlSpot((i + 1).toDouble(), widget.sensorData[i]['pH'].toDouble()));
      tempSpot.add(FlSpot(
          (i + 1).toDouble(), widget.sensorData[i]['temperature'].toDouble()));
      moistureSpot.add(FlSpot(
          (i + 1).toDouble(), widget.sensorData[i]['moisture'].toDouble()));
      humiditySpot.add(FlSpot(
          (i + 1).toDouble(), widget.sensorData[i]['humidity'].toDouble()));
    }

    setState(() {
      nSpot;
      pSpot;
      kSpot;
      phSpot;
      tempSpot;
      moistureSpot;
      humiditySpot;
    });
  }

  @override
  void initState() {
    super.initState();
    getSensorData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// NPK history
              const SizedBox(
                height: 10,
              ),
              NpkHistory(nSpot: nSpot, pSpot: pSpot, kSpot: kSpot),

              /// Ph history
              const SizedBox(
                height: 10,
              ),
              PhHistory(
                phSpot: phSpot,
              ),

              /// Temperature history
              const SizedBox(height: 10),
              TempHistory(
                tempSpot: tempSpot,
              ),

              /// Moisture history
              const SizedBox(
                height: 10,
              ),
              MoistureHistory(
                moistureSpot: moistureSpot,
              ),

              /// Humidity history
              const SizedBox(height: 10),
              HumidityHistory(
                humiditySpot: humiditySpot,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }
}
