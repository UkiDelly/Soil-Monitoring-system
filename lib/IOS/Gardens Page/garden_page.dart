import 'dart:convert';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'plant_card.dart';
import '../History Page/history_page.dart';
import 'Garden Page widgets/garden_page_name.dart';
import 'Garden Page widgets/humidity.dart';
import 'Garden Page widgets/moisture.dart';
import 'Garden Page widgets/npk_status.dart';
import 'Garden Page widgets/ph_level.dart';
import 'Garden Page widgets/tempurature.dart';

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
        systemOverlayStyle: SystemUiOverlayStyle.light,

//* Back button
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),

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

// * Send server the new name
                  });
                  // change the icon the setting
                  isSettingPressed = false;
                }
              });
            },
            icon: isSettingPressed == false
                ? const Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 30,
                  )
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

//* Name of the Garden
                    GardenName(
                      name: gardenName,
                      isSettingPressed: isSettingPressed,
                      controller: nameControl,
                    ),

//* Body
                    Container(
                      padding: const EdgeInsets.only(top: 10),
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
//* Plants
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

//*Plants card
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
