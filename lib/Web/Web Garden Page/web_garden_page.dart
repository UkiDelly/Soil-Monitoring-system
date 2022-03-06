// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../IOS/Gardens Page/Garden Page widgets/humidity.dart';
import '../../IOS/Gardens Page/Garden Page widgets/moisture.dart';
import '../../IOS/Gardens Page/Garden Page widgets/npk_status.dart';
import '../../IOS/Gardens Page/Garden Page widgets/ph_level.dart';
import '../../IOS/Gardens Page/Garden Page widgets/tempurature.dart';
import '../../IOS/History Page/History page Widgets/humidity_history.dart';
import '../../IOS/History Page/History page Widgets/moisture_history.dart';
import '../../IOS/History Page/History page Widgets/npk_history.dart';
import '../../IOS/History Page/History page Widgets/ph_history.dart';
import '../../IOS/History Page/History page Widgets/temperature.dart';
import 'web_plant_card.dart';

class WebGardenPage extends StatefulWidget {
  bool isPressed;
  int indexTapped;
  WebGardenPage({Key? key, required this.indexTapped, required this.isPressed})
      : super(key: key);

  @override
  _WebGardenPageState createState() => _WebGardenPageState();
}

class _WebGardenPageState extends State<WebGardenPage> {
  //?dump data
  bool isSettingPressed = false;
  String gardenName = "Garden";
  late Map<String, double> dataMap = {"": 0};
  double ph = 0, moisture = 0, temp = 0, humidity = 0;
  // Map<String, double> dataMap = {"N": 30, "P": 30, "K": 30};
  // double ph = 7;
  // double moisture = 46;
  // double temp = 31, humidity = 30;
  String comment = "Comment for the Garden";

  TextEditingController nameControl = TextEditingController();

  //* Load date from the json file
  readJson() async {
    final String response = await rootBundle.loadString('assets/dump.json');
    final data = await json.decode(response);

    setState(() {
      ph = data["ph"];
      moisture = data["moisture"];
      temp = data["temp"];
      humidity = data["humidity"];
      dataMap = {"N": data["N"], "P": data["P"], "K": data["K"]};
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //* Left Side, Status
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
                                    PhLevel(ph: ph),
                                    const SizedBox(width: 10),
                                    MoistureLevel(moisture: moisture),
                                    const SizedBox(width: 10),
                                    Temp(temp: temp),
                                    const SizedBox(width: 10),
                                    Humidity(
                                      humidity: humidity,
                                    ),
                                  ],
                                ))
                            : null),

                    //* Right Side, History
                    Expanded(
                        child: Container(
                      height: 400,
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Center(
                          child: Row(
                            children: [
                              //? NPK history
                              const SizedBox(
                                width: 10,
                              ),
                              NPKHistory(
                                width: 400,
                              ),

                              //? Ph history
                              const SizedBox(
                                width: 10,
                              ),
                              PhHistory(
                                width: 400,
                              ),

                              //? Moisture history
                              const SizedBox(
                                width: 10,
                              ),
                              MoistureHistory(
                                width: 400,
                              ),

                              //? Temperature history
                              const SizedBox(width: 10),
                              TempHistory(width: 400),

                              //? Humidity history
                              const SizedBox(),
                              HumidityHistory(
                                width: 400,
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),

              //* Divider
              const Divider(
                  indent: 10,
                  endIndent: 10,
                  color: Color.fromARGB(255, 246, 245, 245)),

              //* Plant Text
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Plants that can be plant",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              //
              const SizedBox(
                height: 10,
              ),
              //* Plant Card
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 330,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) => const WebPlantCard(),
                ),
              )
            ],
          ),
        ));
  }
}
