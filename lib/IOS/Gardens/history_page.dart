import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesis/IOS/Gardens/History%20page%20Widgets/humidity_history.dart';
import 'package:thesis/IOS/Gardens/History%20page%20Widgets/moisture_history.dart';
import 'package:thesis/IOS/Gardens/History%20page%20Widgets/npk_history.dart';
import 'package:thesis/IOS/Gardens/History%20page%20Widgets/ph_history.dart';
import 'package:thesis/IOS/Gardens/History%20page%20Widgets/temperature.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff669D6B),
        appBar: AppBar(
          backgroundColor: const Color(0xff669D6B),
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/back.svg',
              width: 15,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            "Soil Status History",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// NPK history
                  const SizedBox(
                    height: 10,
                  ),
                  NPKHistory(),

                  /// Ph history
                  const SizedBox(
                    height: 10,
                  ),
                  PhHistory(),

                  /// Moisture history
                  const SizedBox(
                    height: 10,
                  ),
                  MoistureHistory(),

                  /// Temperature history
                  const SizedBox(height: 10),
                  TempHistory(),

                  /// Humidity history
                  const SizedBox(height: 10),
                  HumidityHistory()
                ],
              ),
            ),
          ),
        ));
  }
}
