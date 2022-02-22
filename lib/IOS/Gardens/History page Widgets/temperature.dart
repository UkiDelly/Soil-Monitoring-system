import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/Gardens/History%20page%20Widgets/line_chart_history.dart';

class TempHistory extends StatelessWidget {
  TempHistory({Key? key}) : super(key: key);

  List<FlSpot> spots = [];

  @override
  Widget build(BuildContext context) {
    HistoryChart tempHistory = HistoryChart(
        title: "Temp History",
        minX: 1,
        maxX: 7,
        minY: 0,
        leftSideInterval: 20,
        maxY: 100,
        spots: spots,
        showDot: true);
    return tempHistory.historyChart(context);
  }
}
