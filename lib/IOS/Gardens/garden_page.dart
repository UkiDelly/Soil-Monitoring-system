import 'dart:convert';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/garden_page_name.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/humidity.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/ph_level.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/tempurature.dart';
import 'package:thesis/IOS/Gardens/history_page.dart';
import '../Garden and plant card/plant_card.dart';
import 'Garden Page widgets/moisture.dart';
import 'Garden Page widgets/npk_status.dart';

class Garden extends StatefulWidget {
  const Garden({Key? key}) : super(key: key);

  @override
  _GardenState createState() => _GardenState();
}



class _GardenState extends State<Garden> {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: const Color(0xff669D6B),
        elevation: 0,

        //* Back button
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: SvgPicture.asset(
            'assets/back.svg',
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        //* My Gardens
        // title: Text("My Gardens"),
        // titleTextStyle: const TextStyle(
        //     color: Colors.black,
        //     fontSize: 15,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: "Readex Pro"),
        // centerTitle: false,
        // titleSpacing: -10,

        //* History button, setting button
        actions: [
          //* History button
          IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                        context,
                        PageTransition(
                            duration: const Duration(milliseconds: 595),
                            child: const HistoryPage(),
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

          //* Setting button
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
      body: SingleChildScrollView(
        child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SafeArea(
              bottom: true,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    GardenName(
                      name: gardenName,
                      isSettingPressed: isSettingPressed,
                      controller: nameControl,
                    ),
                    //* Name of the Garden

                    //* Body
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      //height: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //? Left Column
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //
                                const SizedBox(
                                  height: 10,
                                ),

                                //* NPK status
                                TranslationAnimatedWidget.tween(
                                  duration: const Duration(seconds: 1),
                                  enabled: true,
                                  translationDisabled: const Offset(-500, 0),
                                  translationEnabled: const Offset(0, 0),
                                  curve: Curves.fastOutSlowIn,
                                  child: OpacityAnimatedWidget.tween(
                                    duration: const Duration(seconds: 1),
                                    enabled: true,
                                    opacityDisabled: 0,
                                    opacityEnabled: 1,
                                    child: NPKstatus(dataMap: dataMap),
                                  ),
                                ),

                                //
                                const SizedBox(
                                  height: 10,
                                ),

                                //* Temperature
                                TranslationAnimatedWidget.tween(
                                  delay: const Duration(milliseconds: 700),
                                  duration: const Duration(seconds: 1),
                                  enabled: true,
                                  translationDisabled: const Offset(-500, 0),
                                  translationEnabled: const Offset(0, 0),
                                  curve: Curves.fastOutSlowIn,
                                  child: OpacityAnimatedWidget.tween(
                                      duration: const Duration(seconds: 1),
                                      enabled: true,
                                      opacityDisabled: 0,
                                      opacityEnabled: 1,
                                      child: Temp(
                                        temp: temp,
                                      )),
                                ),
                              ],
                            ),
                          ),

                          //? Right Column
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              //* Ph Level
                              TranslationAnimatedWidget.tween(
                                delay: const Duration(milliseconds: 300),
                                duration: const Duration(seconds: 1),
                                enabled: true,
                                translationDisabled: const Offset(500, 0),
                                translationEnabled: const Offset(0, 0),
                                curve: Curves.fastOutSlowIn,
                                child: OpacityAnimatedWidget.tween(
                                  duration: const Duration(seconds: 1),
                                  enabled: true,
                                  opacityDisabled: 0,
                                  opacityEnabled: 1,
                                  child: PhLevel(
                                    ph: ph,
                                  ),
                                ),
                              ),

                              //
                              const SizedBox(
                                height: 10,
                              ),

                              //* Moisture
                              TranslationAnimatedWidget.tween(
                                delay: const Duration(milliseconds: 500),
                                duration: const Duration(seconds: 1),
                                enabled: true,
                                translationDisabled: const Offset(500, 0),
                                translationEnabled: const Offset(0, 0),
                                curve: Curves.fastOutSlowIn,
                                child: OpacityAnimatedWidget.tween(
                                  duration: const Duration(seconds: 1),
                                  enabled: true,
                                  opacityDisabled: 0,
                                  opacityEnabled: 1,
                                  child: MoistureLevel(
                                    moisture: moisture,
                                  ),
                                ),
                              ),

                              //
                              const SizedBox(
                                height: 20,
                              ),

                              //* Humidity
                              TranslationAnimatedWidget.tween(
                                delay: const Duration(milliseconds: 900),
                                duration: const Duration(seconds: 1),
                                enabled: true,
                                translationDisabled: const Offset(500, 0),
                                translationEnabled: const Offset(0, 0),
                                curve: Curves.fastOutSlowIn,
                                child: OpacityAnimatedWidget.tween(
                                  duration: const Duration(seconds: 1),
                                  enabled: true,
                                  opacityDisabled: 0,
                                  opacityEnabled: 1,
                                  child: Humidity(
                                    humidity: humidity,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    //? Divider
                    const SizedBox(
                      height: 10,
                    ),

                    const Divider(
                      color: Color(0xfffffff0),
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                      height: 10,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // Plants
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            "Plants",
                            style: (TextStyle(
                                fontFamily: "Readex Pro",
                                fontSize: 40,
                                fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),

                    //Plants card
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.8,
                      child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return const PlantCard();
                          }),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
