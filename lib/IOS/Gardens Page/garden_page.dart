import 'dart:convert';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/Gardens%20Page/plant_card.dart';
import 'package:thesis/provider.dart';
import '../History Page/history_page.dart';
import 'Garden Page widgets/garden_page_name.dart';
import 'Garden Page widgets/humidity.dart';
import 'Garden Page widgets/moisture.dart';
import 'Garden Page widgets/npk_status.dart';
import 'Garden Page widgets/ph_level.dart';
import 'Garden Page widgets/tempurature.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class NewGardenPage extends StatelessWidget {
  String gardenID;
  String gardenName;
  NewGardenPage({Key? key, required this.gardenID, required this.gardenName})
      : super(key: key);

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
                          type: PageTransitionType.rightToLeft));
                },
                icon: const Icon(
                  Icons.insert_chart_outlined,
                  color: Colors.white,
                  size: 30,
                )),
          ],
        ),

        //* Content
        backgroundColor: const Color(0xff669D6B),
        body: Consumer(
          builder: (ctx, ref, child) {
            final token = ref.watch(tokenProvider);
            return _Garden(
              token: token,
              gardenID: gardenID,
            );
          },
        ));
  }
}

// ignore: must_be_immutable
class _Garden extends StatefulWidget {
  String token;
  String gardenID;
  _Garden({Key? key, required this.gardenID, required this.token})
      : super(key: key);

  @override
  State<_Garden> createState() => __GardenState();
}

class __GardenState extends State<_Garden> {
  //
  //? Get the garden data
  getGarden() async {
    final url = "http://soilanalysis.loca.lt/v1/garden/get/${widget.gardenID}";
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.token}'});
    var item = jsonDecode(response.body);
    setState(() {
      data = item["data"];
      gardenName = data["name"];
    });
  }

  Map<String, double> npkMap = {"N": 30, "P": 30, "K": 30};
  double ph = 7;
  double moisture = 46;
  double temp = 31, humidity = 30;
  var data = {};
  String gardenName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGarden();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        bottom: true,
        child: SizedBox(
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
                              child: NPKstatus(dataMap: npkMap),
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
                color: Color.fromARGB(255, 246, 245, 245),
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
      ),
    );
  }
}
