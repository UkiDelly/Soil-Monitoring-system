import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/Gardens/History%20page%20Widgets/line_chart_history.dart';

class TempHistory extends StatelessWidget {
  TempHistory({Key? key}) : super(key: key);

  List<FlSpot> spots = [
    const FlSpot(1, 20),
    const FlSpot(2, 30),
    const FlSpot(3, 13),
    const FlSpot(4, 99),
    const FlSpot(5, 35),
    const FlSpot(6, 12),
    const FlSpot(7, 78),
  ];

  List<Color> colors = [
    Colors.blueAccent,
    Colors.redAccent,
  ];

  @override
  Widget build(BuildContext context) {
    HistoryChart tempHistory = HistoryChart(
      title: const Text("Temp History",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      minX: 1,
      maxX: 7,
      minY: 0,
      leftSideInterval: 20,
      maxY: 100,
      spots: spots,
      showDot: false,
      lineChartBarWidth: false,
      belowBarArea: true,
      belowBarColors: colors,
    );
    return tempHistory.historyChart(context);
  }
}
