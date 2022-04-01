// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'line_chart_history.dart';

class PhHistory extends StatelessWidget {
  double? width;
  PhHistory({Key? key, this.width}) : super(key: key);

  final List<FlSpot> pHspots = const [
    FlSpot(1, 7),
    FlSpot(2, 3),
    FlSpot(3, 2),
    FlSpot(4, 6.5),
    FlSpot(5, 8.9),
    FlSpot(6, 3.2),
    FlSpot(7, 5),
  ];

  List<Color> gradientColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.indigo
  ];

  @override
  Widget build(BuildContext context) {
    //? create ph history chart
    HistoryChart phHistory = HistoryChart(
      title: const Text(
        "Ph History",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      minX: 1,
      maxX: 7,
      minY: 1,
      maxY: 14,
      spots: pHspots,
      showDot: false,
      belowBarArea: true,
      lineChartBarWidth: false,
      belowBarColors: gradientColors,
      lineChartBarGradient: true,
      width: width,
    );

    return phHistory.historyChart(context);
  }
}
