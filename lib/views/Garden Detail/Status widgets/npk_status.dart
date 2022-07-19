// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class NPKstatus extends StatelessWidget {
  late Map<String, double> dataMap;
  double width;
  NPKstatus({Key? key, required this.dataMap, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //300
      width: width,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Nutrient",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            /// Chart
            PieChart(
              // Data Map of the chart
              dataMap: dataMap,
              emptyColor: Colors.white,
              chartRadius: 150,
              animationDuration: const Duration(milliseconds: 1000),

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
