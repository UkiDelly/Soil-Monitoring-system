// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/Status%20widgets/npk_status.dart';
import 'package:thesis/Main/loading.dart';

import 'package:http/http.dart' as http;
import '../../Main/provider.dart';
import '../../Status widgets/humidity.dart';
import '../../Status widgets/moisture.dart';
import '../../Status widgets/ph_level.dart';
import '../../Status widgets/tempurature.dart';
import '../History Page/web_history_page.dart';

class WebGarden extends ConsumerWidget {
  WebGarden({
    Key? key,
  }) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokenProvider);
    final gardenID = ref.watch(gardenIDProvider);
    final sensorIdList = ref.watch(sensorIdListProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
      child: ref.watch(selectionProvider).isSelected
          ? SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,

              //
              child: _Status(
                token: token,
                gardenID: gardenID,
                key: UniqueKey(),
                sensorIdList: sensorIdList,
              ))
          : Opacity(
              opacity: 0.25,
              child: Center(child: Image.asset('Logo/Logo.png'))),
    );
  }
}

class _Status extends ConsumerStatefulWidget {
  String token, gardenID;
  var sensorIdList;
  _Status(
      {Key? key,
      required this.token,
      required this.gardenID,
      required this.sensorIdList})
      : super(key: key);

  @override
  ConsumerState<_Status> createState() => __StatusState();
}

class __StatusState extends ConsumerState<_Status> {
  // var

  late Map<String, double> npkMap = {
    "Nitrogen": 10,
    "Potassium": 10,
    "Phosphorous": 10
  };
  late double ph, temp, moisture, humidity;
  bool isLoading = false;
  var garden;

  List<FlSpot> nSpot = [],
      pSpot = [],
      kSpot = [],
      phSpot = [],
      tempSpot = [],
      moistureSpot = [],
      humiditySpot = [];

  getData() async {
    setState(() {
      isLoading = true;
    });

    var _sensorId;

    //search the match gardenId inside the sensorId List
    for (var item in widget.sensorIdList) {
      if (widget.gardenID == item['gardenId']) {
        _sensorId = item['sensorId'];
      }
    }

    // final url = "https://soilanalysis.loca.lt/v1/garden/get/$gardenID";
    final url = "http://localhost:3000/v1/garden/get/${widget.gardenID}";
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer ${widget.token}',
    });
    var item = jsonDecode(response.body);

    // get the gardne name
    var _gardenName = item['data']['name'];

    // get the sensor
    final sensorUrl = "http://localhost:3000/v1/sensor/get/$_sensorId";
    response = await http.get(Uri.parse(sensorUrl), headers: {
      'Authorization': 'Bearer ${widget.token}',
    });
    item = jsonDecode(response.body);

    // set the garden name
    item['data']["name"] = _gardenName;

    // get the latest data
    if (response.statusCode == 200) {
      var sensorData = item['data']['data'].last;
      var _sensorDataList = item['data']['data'];

      //Make the Histroy
      //If the data list is more than 7,
      if (_sensorDataList.length > 7) {
        for (int i = 0; i < 7; i++) {
          // get each sensor data and covert into a spot
          nSpot.add(FlSpot(
              (i + 1).toDouble(), _sensorDataList[i]['nitrogen'].toDouble()));
          pSpot.add(FlSpot((i + 1).toDouble(),
              _sensorDataList[i]['phosphorous'].toDouble()));
          kSpot.add(FlSpot(
              (i + 1).toDouble(), _sensorDataList[i]['potassium'].toDouble()));
          phSpot.add(
              FlSpot((i + 1).toDouble(), _sensorDataList[i]['pH'].toDouble()));
          tempSpot.add(FlSpot((i + 1).toDouble(),
              _sensorDataList[i]['temperature'].toDouble()));
          moistureSpot.add(FlSpot(
              (i + 1).toDouble(), _sensorDataList[i]['moisture'].toDouble()));
          humiditySpot.add(FlSpot(
              (i + 1).toDouble(), _sensorDataList[i]['humidity'].toDouble()));
        }
        //if less than 7,
      } else {
        for (int i = _sensorDataList.length - 1; i >= 0; i--) {
          nSpot.add(FlSpot(
              (i + 1).toDouble(), _sensorDataList[i]['nitrogen'].toDouble()));
          pSpot.add(FlSpot((i + 1).toDouble(),
              _sensorDataList[i]['phosphorous'].toDouble()));
          kSpot.add(FlSpot(
              (i + 1).toDouble(), _sensorDataList[i]['potassium'].toDouble()));
          phSpot.add(
              FlSpot((i + 1).toDouble(), _sensorDataList[i]['pH'].toDouble()));
          tempSpot.add(FlSpot((i + 1).toDouble(),
              _sensorDataList[i]['temperature'].toDouble()));
          moistureSpot.add(FlSpot(
              (i + 1).toDouble(), _sensorDataList[i]['moisture'].toDouble()));
          humiditySpot.add(FlSpot(
              (i + 1).toDouble(), _sensorDataList[i]['humidity'].toDouble()));
        }
      }

      // get the sensor data values
      if (mounted) {
        setState(() {
          // latest data
          garden = item;
          npkMap["Nitrogen"] = sensorData['nitrogen'].toDouble();
          npkMap["Potassium"] = sensorData['potassium'].toDouble();
          npkMap["Phosphorous"] = sensorData['phosphorous'].toDouble();
          ph = sensorData['pH'].toDouble();
          temp = sensorData['temperature'].toDouble();
          moisture = sensorData['moisture'].toDouble();
          humidity = sensorData['humidity'].toDouble();

          //History
          nSpot;
          pSpot;
          kSpot;
          phSpot;
          tempSpot;
          moistureSpot;
          humiditySpot;

          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: LoadingPage(),
          )
        : Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            color: const Color(0xff669D6B),
            child: Column(
              children: [
                //* Garden Name
                OpacityAnimatedWidget.tween(
                    duration: const Duration(seconds: 1),
                    enabled: true,
                    opacityDisabled: 0,
                    opacityEnabled: 1,
                    child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 246, 245, 245),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          garden['data']['name'],
                          style: const TextStyle(fontSize: 35),
                        ))),
                // Status
                Wrap(
                  children: [
                    OpacityAnimatedWidget(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(seconds: 1),
                        enabled: true,
                        child: NPKstatus(dataMap: npkMap)),

                    //
                    OpacityAnimatedWidget(
                        delay: const Duration(milliseconds: 600),
                        duration: const Duration(seconds: 1),
                        enabled: true,
                        child: PhLevel(ph: ph)),

                    //
                    OpacityAnimatedWidget(
                      delay: const Duration(milliseconds: 900),
                      duration: const Duration(seconds: 1),
                      enabled: true,
                      child: Temp(temp: temp),
                    ),

                    //
                    OpacityAnimatedWidget(
                      delay: const Duration(milliseconds: 1200),
                      duration: const Duration(seconds: 1),
                      enabled: true,
                      child: MoistureLevel(moisture: moisture),
                    ),

                    //
                    OpacityAnimatedWidget(
                        delay: const Duration(milliseconds: 1600),
                        duration: const Duration(seconds: 1),
                        enabled: true,
                        child: Humidity(humidity: humidity)),
                  ],
                ),

                //
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 3,
                ),

                //TODO: Create History page
                SizedBox(
                  child: WebHistory(
                    nSpot: nSpot,
                    pSpot: pSpot,
                    kSpot: kSpot,
                    phSpot: phSpot,
                    tempSpot: tempSpot,
                    moistureSpot: moistureSpot,
                    humiditySpot: humiditySpot,
                  ),
                )

                //
              ],
            ),
          );
  }
}

// If the width is less tha 550
class WebGardenMini extends StatelessWidget {
  const WebGardenMini({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebGarden(

          //gardenID: gardenID,
          ),
    );
  }
}
