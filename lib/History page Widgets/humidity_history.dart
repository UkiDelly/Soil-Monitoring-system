// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'line_chart_history.dart';

class HumidityHistory extends StatelessWidget {
  double? width;
  List<FlSpot>? humiditySpot;
  HumidityHistory({Key? key, this.width, this.humiditySpot}) : super(key: key);

  List<FlSpot> spots = [const FlSpot(3, 50), const FlSpot(1, 44)];

  @override
  Widget build(BuildContext context) {
    HistoryChart humidityHistory = HistoryChart(
        title: const Text("Humidity History",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        minX: 1,
        maxX: 7,
        minY: 0,
        leftSideInterval: 20,
        maxY: 100,
        spots: humiditySpot ?? spots,
        showDot: true,
        lineColor: [Colors.black87],
        lineChartBarWidth: true,
        width: width);

    return humidityHistory.historyChart(context);
  }
}
