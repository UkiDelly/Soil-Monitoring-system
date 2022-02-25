import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/humidity.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/moisture.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/npk_status.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/phLevel.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/tempurature.dart';

import '../../IOS/Gardens/History page Widgets/moisture_history.dart';
import '../../IOS/Gardens/History page Widgets/npk_history.dart';
import '../../IOS/Gardens/History page Widgets/ph_history.dart';
import '../../IOS/Gardens/History page Widgets/temperature.dart';

class WebGardenPage extends StatefulWidget {
  bool isPressed;
  int indexTapped;
  WebGardenPage({Key? key, required this.indexTapped, required this.isPressed})
      : super(key: key);

  @override
  _WebGardenPageState createState() => _WebGardenPageState();
}

class _WebGardenPageState extends State<WebGardenPage> {
  //? dump data
  Map<String, double> dataMap = {"N": 30, "P": 30, "K": 30};
  double ph = 8;
  double moisture = 50;
  double temp = 60;
  double humidity = 30;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: OpacityAnimatedWidget.tween(
          enabled: true,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 1500),
          opacityDisabled: 0,
          opacityEnabled: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Left Side
              SizedBox(
                  width: widget.isPressed == true ? 400 : 0,
                  child: widget.isPressed == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            direction: Axis.horizontal,
                            children: [
                              NPKstatus(dataMap: dataMap),
                              const SizedBox(width: 10),
                              Ph_Level(ph: ph),
                              const SizedBox(width: 10),
                              Moisture_Level(moisture: moisture),
                              const SizedBox(width: 10),
                              Temp(temp: temp),
                              const SizedBox(width: 10),
                              Humidity(
                                humidity: humidity,
                              ),
                            ],
                          ))
                      : null),

              //* Divider
              const VerticalDivider(
                indent: 20,
                endIndent: 20,
                color: Color(0xfffffff0),
              ),
              //* Right Side
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: Row(
                      children: [
                        /// NPK history
                        const SizedBox(
                          width: 10,
                        ),
                        NPKHistory(
                          width: 400,
                        ),

                        /// Ph history
                        const SizedBox(
                          width: 10,
                        ),
                        PhHistory(
                          width: 400,
                        ),

                        /// Moisture history
                        const SizedBox(
                          width: 10,
                        ),
                        MoistureHistory(
                          width: 400,
                        ),

                        /// Temperature history
                        const SizedBox(width: 10),
                        TempHistory(),

                        /// Humidity history
                        const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
