// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'line_chart_history.dart';

class NpkHistory extends StatelessWidget {
  double? width;
  List<FlSpot>? nSpot, pSpot, kSpot;
  NpkHistory({Key? key, this.width, this.nSpot, this.pSpot, this.kSpot})
      : super(key: key);

  final _nSpot = [
    const FlSpot(1, 100),
    const FlSpot(2, 90),
    const FlSpot(3, 80),
    const FlSpot(4, 70),
    const FlSpot(5, 60),
    const FlSpot(6, 50),
    const FlSpot(7, 40),
  ];
  final _pSpot = [
    const FlSpot(7, 15),
    const FlSpot(6, 15),
    const FlSpot(5, 94),
    const FlSpot(4, 39),
    const FlSpot(3, 38),
    const FlSpot(2, 84),
    const FlSpot(1, 28),
  ];
  final _kSpot = [
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
          fontSize: 25,
          fontWeight: FontWeight.bold,
        )),
  ]));

  @override
  Widget build(BuildContext context) {
    //* Line chart bar data of NPK
    List<LineChartBarData> npkStatus = [
      //? N
      LineChartBarData(
        //* Spots
        spots: nSpot ?? _nSpot,
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
        spots: pSpot ?? _pSpot,
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
        spots: kSpot ?? _kSpot,
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
        maxX: nSpot!.length.toDouble(),
        leftSideInterval: 20,
        minY: 0,
        maxY: 100,
        showDot: true,
        lineChartBarData: npkStatus,
        width: width);

    return npkHistory.historyChart(context);
  }
}
