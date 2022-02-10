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
            PieChart(
              dataMap: widget.dataMap,
              emptyColor: Colors.white,
              chartRadius: 150,
              animationDuration: const Duration(milliseconds: 1500),
              chartLegendSpacing: 10,
              chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
              ),
              ringStrokeWidth: 40,
            )
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
