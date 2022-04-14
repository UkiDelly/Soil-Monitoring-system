import 'dart:convert';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/Gardens%20Page/Plant/plant_card.dart';
import 'package:thesis/Main/loading.dart';

import '../../Main/provider.dart';
import '../../Status widgets/humidity.dart';
import '../../Status widgets/moisture.dart';
import '../../Status widgets/ph_level.dart';
import '../../Status widgets/tempurature.dart';
import '../History Page/history_page.dart';
import '../../Status widgets/npk_status.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class GardenPage extends StatelessWidget {
  GardenPage({
    Key? key,
    required this.gardenId,
    required this.gardenName,
  }) : super(key: key);

  String gardenId;
  String gardenName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 50,
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

//* Garden Name

          title: Text(
            gardenName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,

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
          builder: (context, ref, child) {
            final token = ref.watch(tokenProvider);
            final sensorIdList = ref.watch(sensorIdListProvider);

            return _Garden(
              token: token,
              gardenId: gardenId,
              sensorIdList: sensorIdList,
            );
          },
        ));
  }
}

// ignore: must_be_immutable
class _Garden extends ConsumerStatefulWidget {
  String token;
  String gardenId;
  var sensorIdList;
  _Garden(
      {Key? key,
      required this.token,
      required this.gardenId,
      required this.sensorIdList})
      : super(key: key);

  @override
  ConsumerState<_Garden> createState() => __GardenState();
}

class __GardenState extends ConsumerState<_Garden> {
  //

  bool isLoading = false;

  late Map<String, double> npkMap = {
    "Nitrogen": 30,
    "Potassium": 30,
    "Phosphorous": 30,
  };
  late double ph, moisture, temp, humidity;
  //

  //? Get Sensor Data
  getSensorData() async {
    setState(() {
      isLoading = true;
    });

    var _sensorId = "";

    //search the match gardenId inside the sensorId List
    for (var item in widget.sensorIdList) {
      if (widget.gardenId == item['gardenId']) {
        _sensorId = item['sensorId'];
      }
    }
    final url = "https://soilanalysis.loca.lt/v1/sensor/get/$_sensorId";
    // final url = "http://localhost:3000/v1/sensor/get/$_sensorId";
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.token}'});
    var item = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var _sensorData = item['data']['data'].last;
      ref.watch(sensorDataProvider.notifier).state = item['data']['data'];

      setState(() {
        npkMap = {
          "Nitrogen": _sensorData['nitrogen'].toDouble(),
          "Potassium": _sensorData['potassium'].toDouble(),
          "Phosphorous": _sensorData['phosphorous'].toDouble()
        };

        ph = _sensorData['pH'].toDouble();
        temp = _sensorData['temperature'].toDouble();
        moisture = _sensorData['moisture'].toDouble();
        humidity = _sensorData['humidity'].toDouble();

        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSensorData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        bottom: true,
        child: SizedBox(
            child: isLoading
                ? const Center(child: LoadingPage())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      //* Body
                      SizedBox(
                        child: Column(
                          children: [
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
                                child: NPKstatus(
                                  dataMap: npkMap,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //? Left Column
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        //
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        //
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        //* Temperature
                                        TranslationAnimatedWidget.tween(
                                          delay:
                                              const Duration(milliseconds: 300),
                                          duration: const Duration(seconds: 1),
                                          enabled: true,
                                          translationDisabled:
                                              const Offset(-500, 0),
                                          translationEnabled:
                                              const Offset(0, 0),
                                          curve: Curves.fastOutSlowIn,
                                          child: OpacityAnimatedWidget.tween(
                                              duration:
                                                  const Duration(seconds: 1),
                                              enabled: true,
                                              opacityDisabled: 0,
                                              opacityEnabled: 1,
                                              child: Temp(
                                                temp: temp.toDouble(),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.49,
                                              )),
                                        ),

                                        //* Humidity
                                        TranslationAnimatedWidget.tween(
                                          delay:
                                              const Duration(milliseconds: 500),
                                          duration: const Duration(seconds: 1),
                                          enabled: true,
                                          translationDisabled:
                                              const Offset(-500, 0),
                                          translationEnabled:
                                              const Offset(0, 0),
                                          curve: Curves.fastOutSlowIn,
                                          child: OpacityAnimatedWidget.tween(
                                            duration:
                                                const Duration(seconds: 1),
                                            enabled: true,
                                            opacityDisabled: 0,
                                            opacityEnabled: 1,
                                            child: Humidity(
                                              humidity: humidity.toDouble(),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.49,
                                            ),
                                          ),
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
                                        delay:
                                            const Duration(milliseconds: 300),
                                        duration: const Duration(seconds: 1),
                                        enabled: true,
                                        translationDisabled:
                                            const Offset(500, 0),
                                        translationEnabled: const Offset(0, 0),
                                        curve: Curves.fastOutSlowIn,
                                        child: OpacityAnimatedWidget.tween(
                                          duration: const Duration(seconds: 1),
                                          enabled: true,
                                          opacityDisabled: 0,
                                          opacityEnabled: 1,
                                          child: PhLevel(
                                            ph: ph.toDouble(),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.49,
                                          ),
                                        ),
                                      ),

                                      //
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      //* Moisture
                                      TranslationAnimatedWidget.tween(
                                        delay:
                                            const Duration(milliseconds: 500),
                                        duration: const Duration(seconds: 1),
                                        enabled: true,
                                        translationDisabled:
                                            const Offset(500, 0),
                                        translationEnabled: const Offset(0, 0),
                                        curve: Curves.fastOutSlowIn,
                                        child: OpacityAnimatedWidget.tween(
                                          duration: const Duration(seconds: 1),
                                          enabled: true,
                                          opacityDisabled: 0,
                                          opacityEnabled: 1,
                                          child: MoistureLevel(
                                            moisture: moisture.toDouble(),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.49,
                                          ),
                                        ),
                                      ),

                                      //
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
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
                                  fontSize: 40, fontWeight: FontWeight.bold)),
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
                  )),
      ),
    );
  }
}
