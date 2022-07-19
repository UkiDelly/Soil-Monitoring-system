import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thesis/main.dart';
import 'package:thesis/porivder/garden.dart';
import 'package:thesis/porivder/token.dart';
import 'package:thesis/views/Garden%20Detail/widgets/garden_name.dart';

import '../../models/enum.dart';
import '../loading.dart';
import '../../models/history.dart';
import '../../models/fertilizer.dart';
import '../../models/sensor_data.dart';
import 'Status widgets/humidity.dart';
import 'Status widgets/moisture.dart';
import 'Status widgets/npk_status.dart';
import 'Status widgets/ph_level.dart';
import 'Status widgets/tempurature.dart';
import 'history/history_page.dart';

class GardenPage extends ConsumerStatefulWidget {
  String gardenName, notes;
  Plant plant;
  GardenPage(
      {Key? key,
      required this.gardenName,
      required this.notes,
      required this.plant})
      : super(key: key);

  @override
  ConsumerState<GardenPage> createState() => _GardenPageState();
}

class _GardenPageState extends ConsumerState<GardenPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int pages = 1;
  var getData;
  List<HistoryOfSensorData> history = [];
  late Sensor sensorData;

  // stream data
  StreamController sensorDataStream = StreamController();

  @override
  void initState() {
    super.initState();
    sensorData = Sensor(
        gardenId: ref.watch(gardenIDProvider),
        token: ref.watch(tokenProvider),
        plant: widget.plant);

    // get sensor
    Timer.periodic(const Duration(seconds: 1), (timer) {
      sensorData.getSensorData(sensorDataStream);
    });
  }

  @override
  Widget build(BuildContext context) {
    // check dark mode is on
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? mainDarkColor : mainColor,

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const Spacer(),
          // Add sensor button
          // const IconButton(
          //   onPressed: null,
          //   icon: Icon(Icons.add, size: 30),
          //   splashColor: Colors.transparent,
          //   highlightColor: Colors.transparent,
          // ),

          //History button
          IconButton(
            onPressed: () {
              int index = _pageController.page!.toInt();

              Navigator.push(
                  context,
                  PageTransition(
                      child: HistoryPage(
                        historyData: history[index],
                      ),
                      type: PageTransitionType.rightToLeft));
            },
            icon: const Icon(Icons.history, size: 30),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),

      //
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: StreamBuilder(
            stream: getData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LoadingPage(),
                );
              } else if (snapshot.hasError) {
                return const SizedBox();
              } else if (snapshot.hasData) {
                //Conver object to list
                var _sensorList = snapshot.data as List;

                //* Create history
                for (int i = 0; i < pages; i++) {
                  history.add(HistoryOfSensorData(sensorList: _sensorList[i]));
                  history[i].createHistory();
                }

                //get the average
                double nAverage = 0, pAverage = 0, kAverage = 0, phAverage = 0;

                for (int i = 0; i < pages; i++) {
                  // add all last sensor data
                  nAverage += _sensorList[i].last['nitrogen'];
                  pAverage += _sensorList[i].last['phosphorous'];
                  kAverage += _sensorList[i].last['potassium'];
                  phAverage += _sensorList[i].last['pH'];
                }

                //division to get the average
                nAverage /= pages;
                pAverage /= pages;
                kAverage /= pages;
                phAverage /= pages;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Garden Name, notes
                    GardenInfo(
                      gardenName: widget.gardenName,
                      notes: widget.notes,
                      isDarkMode: isDarkMode,
                    ),

                    const Divider(indent: 10, endIndent: 10, thickness: 3),

                    //Pages
                    _showSensor(_sensorList),

                    const SizedBox(
                      height: 10,
                    ),

                    //Plant selected
                    plant(),

                    const Divider(
                      indent: 15,
                      endIndent: 15,
                      thickness: 3,
                    ),

                    //Fertilizer recommendation
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                      child: Text("Fertilizer recommend",
                          style: TextStyle(
                              fontSize: 33, fontWeight: FontWeight.w500)),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //Fertilizer
                    FertilizerCards(
                      nAverage: nAverage,
                      pAverage: pAverage,
                      kAverage: kAverage,
                      phAverage: phAverage,
                      plant: enumToString(widget.plant),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "No data",
                    style: TextStyle(fontSize: 30),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _showSensor(_sensorList) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 550),
          child: PageView.builder(
              controller: _pageController,
              itemCount: pages,
              itemBuilder: ((context, index) {
                //create history

                var _lastData = _sensorList[index].last;
                return _sensor(_lastData, context);
              })),
        ),

        // Page indicator
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: pages,
            effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.white,
                dotColor: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _sensor(var _lastSensorData, _) {
    // sensor values

    SingleSensorData _singleSensorData = SingleSensorData(
        npk: {
          'Nitrogen': _lastSensorData['nitrogen'].toDouble(),
          'Potassium': _lastSensorData['potassium'].toDouble(),
          'Phosphorous': _lastSensorData['phosphorous'].toDouble(),
        },
        temp: _lastSensorData['temperature'].toDouble(),
        ph: _lastSensorData['pH'].toDouble(),
        humidity: _lastSensorData['humidity'].toDouble(),
        moisture: _lastSensorData['moisture'].toDouble());

    double width = MediaQuery.of(_).size.width * 0.49;
    return Column(
      children: [
        NPKstatus(
            dataMap: _singleSensorData.npk,
            width: MediaQuery.of(_).size.width * 0.9),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Side
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Temperature
                Temp(temp: _singleSensorData.temp, width: width),

                //
                const SizedBox(
                  height: 10,
                ),

                //Humidity
                Humidity(humidity: _singleSensorData.humidity, width: width)
              ],
            ),

            //Right Side
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Ph
                PhLevel(ph: _singleSensorData.ph, width: width),

                //
                const SizedBox(
                  height: 10,
                ),

                //Moisture
                MoistureLevel(
                    moisture: _singleSensorData.moisture, width: width)
              ],
            )
          ],
        )
      ],
    );
  }

  Widget plant() {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 5,
        child: SizedBox(
          child: Column(children: [
            SizedBox(width: 250, child: Image.asset(sensorData.path)),
            Text(
              enumToString(widget.plant).toUpperCase(),
              style: const TextStyle(fontSize: 50),
            )
          ]),
        ),
      ),
    );
  }
}
