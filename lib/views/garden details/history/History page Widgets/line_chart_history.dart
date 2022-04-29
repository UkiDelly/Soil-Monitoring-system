import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoryChart {
  //* Title of the chart
  Widget title;

  //* Min and max value of the chart
  double minX = 0, maxX = 0, minY = 0, maxY = 0;

  //* Interval of the left side of the chart
  late double? leftSideInterval = 1;

  //* Spots of the chart
  List<FlSpot>? spots = [const FlSpot(1, 1)];

  //? Showing the dots?
  bool showDot = true;

  //* line chart bar gradient
  bool? lineChartBarGradient = false;

  //* line chart bar width
  bool? lineChartBarWidth = true;

  //* line color
  late List<Color>? lineColor;
  //* Bellow bar area active
  bool? belowBarArea = false;

  //* Colors below the bar if belowBarArea is true
  List<Color>? belowBarColors = [];

  //* or whole LineChartBarData
  List<LineChartBarData>? lineChartBarData = [];

  //* width of the Container
  late double? width;
  //
  HistoryChart(
      {required this.title,
      required this.minX,
      required this.maxX,
      required this.minY,
      this.leftSideInterval,
      required this.maxY,
      this.spots,
      required this.showDot,
      this.lineChartBarGradient,
      this.lineChartBarWidth,
      this.lineColor,
      this.belowBarArea,
      this.belowBarColors,
      this.lineChartBarData,
      this.width});
  //
  Widget historyChart(_) {
    return SizedBox(
      width: width ?? width,
      height: 350,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title,
            Container(
              padding: const EdgeInsets.fromLTRB(5, 5, 40, 5),
              width: MediaQuery.of(_).size.width - 30,
              height: 300,
              child: SizedBox(
                child: Center(
                  child: LineChart(mainData(
                    lineChartBarData,
                    minX,
                    maxX,
                    minY,
                    leftSideInterval,
                    maxY,
                    spots,
                    showDot,
                    lineChartBarGradient,
                    lineChartBarWidth,
                    lineColor,
                    belowBarArea,
                    belowBarColors,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

LineChartData mainData(
    List<LineChartBarData>? lineChartBarData,
    double minX,
    double maxX,
    double minY,
    double? leftSideInterval,
    double maxY,
    List<FlSpot>? spots,
    bool showDot,
    bool? lineChartBarGradient,
    bool? barWidth,
    List<Color>? lineColor,
    bool? belowBarArea,
    List<Color>? belowBarAreaColor) {
  return LineChartData(
    //* Grid
    gridData: FlGridData(
      show: true,

      //* show Vertical Line
      drawVerticalLine: false,
      //* show Horizontal Line
      drawHorizontalLine: true,

      //* drawer of the vertical line
      getDrawingVerticalLine: (value) {
        return FlLine(color: Colors.grey, strokeWidth: 1);
      },
      //* drawer of the horizontal line
      getDrawingHorizontalLine: (value) {
        return FlLine(color: Colors.grey, strokeWidth: 1);
      },
    ),

    //* Show the chart
    titlesData: FlTitlesData(
        show: true,
        //* Disable the right side
        rightTitles: SideTitles(showTitles: false),
        //* Disable the top side
        topTitles: SideTitles(showTitles: false),

        //* Bottom side
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              // color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            if (value == maxX) {
              return "current";
            }
            return "";
          },
        ),

        //* Left Side
        leftTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          interval: leftSideInterval ?? 1,
          getTextStyles: (context, value) => const TextStyle(
            // color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if (value % 5 == 0) {
              return "${value.toInt()}";
            }
            return "";
          },
          margin: 5,
        )),

    //* Border of the chart
    borderData: FlBorderData(
        show: true,
        border: Border.all(
          // color: const Color(0xff37434d),
          width: 3,
        )),

    //* Show the title of each side
    axisTitleData: FlAxisTitleData(
      show: true,
      bottomTitle: AxisTitle(
          showTitle: false,
          titleText: "Date",
          textStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ),

    //* Value of the chart
    minX: minX,
    maxX: maxX,
    minY: minY,
    maxY: maxY,

    //* Data spot
    lineBarsData: lineChartBarData ??
        [
          LineChartBarData(
              //* Spots
              spots: spots,
              isCurved: true,
              colors: lineColor ?? [const Color.fromARGB(255, 246, 245, 245)],

              //* Gradient from the bottom
              gradientFrom: lineChartBarGradient == true
                  ? const Offset(0, 1)
                  : const Offset(0, 0),
              //* to the top
              gradientTo: lineChartBarGradient == true
                  ? const Offset(0, 0)
                  : const Offset(1, 1),
              //* bar width
              barWidth: barWidth == true ? 3 : 0,

              //* about the dots of the chart
              dotData: FlDotData(show: showDot),

              //* About the below area of the line
              belowBarData: belowBarArea == true
                  ? BarAreaData(
                      show: true,
                      gradientFrom: const Offset(
                        0,
                        1,
                      ),
                      gradientTo: const Offset(0, 0),
                      colors: belowBarAreaColor
                          ?.map((color) => color.withOpacity(0.5))
                          .toList(),
                    )
                  : null)
        ],
  );
}
