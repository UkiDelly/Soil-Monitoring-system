// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class NPKstatus extends StatefulWidget {
  late Map<String, double> dataMap;
  NPKstatus({Key? key, required this.dataMap}) : super(key: key);

  @override
  _NPKstatusState createState() => _NPKstatusState();
}

class _NPKstatusState extends State<NPKstatus> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 170,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Nutrient",
              style: TextStyle(
                  fontFamily: "Readex Pro",
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),

            /// Chart
            PieChart(
              // Data Map of the chart
              dataMap: widget.dataMap,
              emptyColor: Colors.white,
              chartRadius: 150,
              animationDuration: const Duration(milliseconds: 1500),

              //space between the pie chart and the value name
              chartLegendSpacing: 10,

              // change the value into percentage in the chart
              chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: false, showChartValues: true),
              ringStrokeWidth: 40,
            )
          ],
        ),
        // shape of the card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
