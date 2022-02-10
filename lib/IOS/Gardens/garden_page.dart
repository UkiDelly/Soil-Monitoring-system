import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/garden_page_name.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/moisture.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/phLevel.dart';
import 'package:thesis/IOS/Gardens/history_page.dart';
import 'dart:math' as math;

import 'Garden Page widgets/npk_status.dart';

class Garden extends StatefulWidget {
  const Garden({Key? key}) : super(key: key);

  @override
  _GardenState createState() => _GardenState();
}

class _GardenState extends State<Garden> {
  //dump data
  bool isSettingPressed = false;
  String gardenName = "Garden";
  Map<String, double> dataMap = {"N": 30, "P": 30, "K": 30};
  double ph = 7;
  double moisture = 46;

  TextEditingController nameControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: const Color(0xff669D6B),
        elevation: 0,
        // Back button
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: SvgPicture.asset(
            'assets/back.svg',
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        // My Gardens
        title: const Text("My Gardens"),
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Readex Pro"),
        centerTitle: false,
        titleSpacing: 0,

        // History button, setting button
        actions: [
          //History button
          IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                        context,
                        PageTransition(
                            duration: const Duration(milliseconds: 595),
                            child: HistoryPage(),
                            type: PageTransitionType.rightToLeft))
                    .then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(
                Icons.insert_chart_outlined,
                color: Colors.white,
                size: 30,
              )),
          // Setting button
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                // if the icon is setting icon ans it is not pressed,
                if (isSettingPressed == false) {
                  // change the icon to check
                  isSettingPressed = true;
                } else {
                  setState(() {
                    if (nameControl.text != "") gardenName = nameControl.text;
                  });
                  // change the icon the setting
                  isSettingPressed = false;
                }
              });
            },
            icon: isSettingPressed == false
                ? SvgPicture.asset("assets/setting.svg")
                : SvgPicture.asset(
                    "assets/check.svg",
                    height: 20,
                  ),
          )
        ],
      ),
      backgroundColor: const Color(0xff669D6B),
      body: SafeArea(
          bottom: false,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Name of the Garden
                GardenName(
                    gardenName: gardenName,
                    isSettingPressed: isSettingPressed,
                    nameControl: nameControl),

                // Body
                SizedBox(
                  height: 420,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // NPK status
                          SizedBox(
                            child: NPKstatus(dataMap: dataMap),
                          ),

                          //
                          const SizedBox(
                            height: 10,
                          ),

                          // Ph Level
                          PhLevel(
                            ph: ph,
                          ),

                          //
                          const SizedBox(
                            height: 10,
                          ),

                          // Moisture
                          MoistureLevel(
                            moisture: moisture,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bottom
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xfffefefe),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 30,
                            offset: const Offset(0, 10))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

// Random color
Color randomColor() {
  var g = math.Random.secure().nextInt(255);
  var b = math.Random.secure().nextInt(255);
  var r = math.Random.secure().nextInt(255);
  return Color.fromARGB(255, r, g, b);
}
