import 'package:flutter/material.dart';
import 'package:thesis/History%20page%20Widgets/humidity_history.dart';
import 'package:thesis/History%20page%20Widgets/moisture_history.dart';
import 'package:thesis/History%20page%20Widgets/npk_history.dart';
import 'package:thesis/History%20page%20Widgets/ph_history.dart';
import 'package:thesis/History%20page%20Widgets/temperature.dart';

class WebHistory extends StatelessWidget {
  const WebHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //* NPK History
          SizedBox(child: NpkHistory()),

          // pH History
          PhHistory(),

          // Temperature History
          TempHistory(),

          // Moisture History
          MoistureHistory(),

          // Humidity History
          HumidityHistory(),
        ],
      ),
    );
  }
}
