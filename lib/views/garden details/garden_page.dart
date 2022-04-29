import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thesis/main.dart';

import '../../loading.dart';
import '../../models/history.dart';
import '../../models/fertilizer.dart';
import '../../models/single_sensor.dart';
import 'Status widgets/humidity.dart';
import 'Status widgets/moisture.dart';
import 'Status widgets/npk_status.dart';
import 'Status widgets/ph_level.dart';
import 'Status widgets/tempurature.dart';
import 'history/history_page.dart';

class GardenPage extends StatefulWidget {
  String gardenId, gardenName, token, notes, plant;
  GardenPage(
      {Key? key,
      required this.gardenId,
      required this.gardenName,
      required this.token,
      required this.notes,
      required this.plant})
      : super(key: key);

  @override
  State<GardenPage> createState() => _GardenPageState();
}

class _GardenPageState extends State<GardenPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int pages = 1;
  var getData;
  List<HistoryOfSensorData> history = [];
  late Sensor sensorData;

  @override
  void initState() {
    super.initState();
    sensorData = Sensor(gardenId: widget.gardenId, token: widget.token);
    getData = sensorData.getSensorData(widget.plant);
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
          child: FutureBuilder(
            future: getData,
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
                    gardenInfo(isDarkMode),

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
                      plant: widget.plant,
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

  Widget gardenInfo(isDarkMode) {
    return Column(
      children: [
        Center(
            child: Text(
          widget.gardenName,
          style: const TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
        )),
        const SizedBox(
          height: 10,
        ),

        //Notes
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(12.5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "notes",
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 17),
                    ),
                  ),
                  Divider(
                    color: isDarkMode ? Colors.white : Colors.black,
                    indent: 5,
                    endIndent: 5,
                    thickness: 2,
                  ),
                  Text(
                    widget.notes,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
              widget.plant,
              style: const TextStyle(fontSize: 50),
            )
          ]),
        ),
      ),
    );
  }
}
