import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/main.dart';

import 'History page Widgets/humidity_history.dart';
import 'History page Widgets/moisture_history.dart';
import 'History page Widgets/npk_history.dart';
import 'History page Widgets/ph_history.dart';
import 'History page Widgets/temperature.dart';

class HistoryPage extends StatelessWidget {
  var historyData;
  HistoryPage({Key? key, required this.historyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
            return _History(
              sensorData: historyData,
            );
          },
        ));
  }
}

// ignore: must_be_immutable
class _History extends StatefulWidget {
  var sensorData;
  _History({Key? key, required this.sensorData}) : super(key: key);

  @override
  State<_History> createState() => __HistoryState();
}

class __HistoryState extends State<_History> {
  @override
  void initState() {
    super.initState();
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
              NpkHistory(
                  nSpot: widget.sensorData.nSpot,
                  pSpot: widget.sensorData.pSpot,
                  kSpot: widget.sensorData.kSpot),

              /// Ph history
              const SizedBox(
                height: 10,
              ),
              PhHistory(
                phSpot: widget.sensorData.phSpot,
              ),

              /// Temperature history
              const SizedBox(height: 10),
              TempHistory(
                tempSpot: widget.sensorData.tempSpot,
              ),

              /// Moisture history
              const SizedBox(
                height: 10,
              ),
              MoistureHistory(
                moistureSpot: widget.sensorData.moistureSpot,
              ),

              /// Humidity history
              const SizedBox(height: 10),
              HumidityHistory(
                humiditySpot: widget.sensorData.humiditySpot,
              )
            ],
          ),
        ),
      ),
    );
  }
}
