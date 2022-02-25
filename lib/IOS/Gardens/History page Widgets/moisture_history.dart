import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/Gardens/History%20page%20Widgets/line_chart_history.dart';

class MoistureHistory extends StatelessWidget {
  double? width;
  MoistureHistory({Key? key, this.width}) : super(key: key);

  List<FlSpot> spots = [const FlSpot(3, 50), const FlSpot(1, 44)];

  @override
  Widget build(BuildContext context) {
    HistoryChart moistureHistory = HistoryChart(
        title: const Text("Moisture History",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        minX: 1,
        maxX: 7,
        minY: 0,
        leftSideInterval: 20,
        maxY: 100,
        spots: spots,
        showDot: true,
        lineColor: [Colors.lightBlueAccent],
        lineChartBarWidth: true,
        width: width);

    return moistureHistory.historyChart(context);
  }
}
