// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'line_chart_history.dart';

class MoistureHistory extends StatelessWidget {
  double? width;
  List<FlSpot>? moistureSpot;
  MoistureHistory({Key? key, this.width, this.moistureSpot}) : super(key: key);

  List<FlSpot> spots = [const FlSpot(3, 50), const FlSpot(1, 44)];

  @override
  Widget build(BuildContext context) {
    HistoryChart moistureHistory = HistoryChart(
        title: const Text("Moisture History",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        minX: 1,
        maxX: moistureSpot!.length.toDouble(),
        minY: 0,
        leftSideInterval: 20,
        maxY: 100,
        spots: moistureSpot ?? spots,
        showDot: true,
        lineColor: [Colors.lightBlueAccent],
        lineChartBarWidth: true,
        width: width);

    return moistureHistory.historyChart(context);
  }
}
