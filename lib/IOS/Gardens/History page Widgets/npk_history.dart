// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/Gardens/History%20page%20Widgets/line_chart_history.dart';

class NPKHistory extends StatelessWidget {
  double? width;
  NPKHistory({Key? key, this.width}) : super(key: key);

  List<FlSpot> nSpot = [
    const FlSpot(1, 100),
    const FlSpot(2, 90),
    const FlSpot(3, 80),
    const FlSpot(4, 70),
    const FlSpot(5, 60),
    const FlSpot(6, 50),
    const FlSpot(7, 40),
  ];
  List<FlSpot> pSpot = [
    const FlSpot(7, 15),
    const FlSpot(6, 15),
    const FlSpot(5, 94),
    const FlSpot(4, 39),
    const FlSpot(3, 38),
    const FlSpot(2, 84),
    const FlSpot(1, 28),
  ];
  List<FlSpot> kSpot = [
    const FlSpot(7, 29),
    const FlSpot(6, 52),
    const FlSpot(5, 23),
    const FlSpot(4, 72),
    const FlSpot(3, 74),
    const FlSpot(2, 88),
    const FlSpot(1, 15),
  ];

  RichText npkTitle = RichText(
      text: const TextSpan(children: [
    TextSpan(
        text: "N",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue)),
    TextSpan(
        text: "P",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent)),
    TextSpan(
        text: "K",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent)),
    TextSpan(
        text: " History",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
  ]));

  @override
  Widget build(BuildContext context) {
    //* Line chart bar data of NPK
    List<LineChartBarData> npkStatus = [
      //? N
      LineChartBarData(
        //* Spots
        spots: nSpot,
        isCurved: true,
        colors: [Colors.lightBlue],

        //* bar width
        barWidth: 3,

        //* about the dots of the chart
        dotData: FlDotData(show: true),
      ),

      //? P
      LineChartBarData(
        //* Spots
        spots: pSpot,
        isCurved: true,
        colors: [Colors.redAccent],

        //* bar width
        barWidth: 3,

        //* about the dots of the chart
        dotData: FlDotData(show: true),
      ),

      //? K
      LineChartBarData(
        //* Spots
        spots: kSpot,
        isCurved: true,
        colors: [Colors.purpleAccent],

        //* bar width
        barWidth: 3,

        //* about the dots of the chart
        dotData: FlDotData(show: true),
      ),
    ];

    //* call the Chart
    HistoryChart npkHistory = HistoryChart(
        title: npkTitle,
        minX: 1,
        maxX: 7,
        leftSideInterval: 20,
        minY: 0,
        maxY: 100,
        showDot: true,
        lineChartBarData: npkStatus,
        width: width);

    return npkHistory.historyChart(context);
  }
}
