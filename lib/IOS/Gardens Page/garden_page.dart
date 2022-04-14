import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thesis/IOS/History%20Page/history_page.dart';
import 'package:http/http.dart' as http;
import 'package:thesis/Status%20widgets/humidity.dart';
import 'package:thesis/Status%20widgets/moisture.dart';
import 'package:thesis/Status%20widgets/npk_status.dart';
import 'package:thesis/Status%20widgets/ph_level.dart';
import 'package:thesis/Status%20widgets/tempurature.dart';

class GardenPage extends StatefulWidget {
  String gardenId, gardenName, token, notes;
  GardenPage(
      {Key? key,
      required this.gardenId,
      required this.gardenName,
      required this.token,
      required this.notes})
      : super(key: key);

  @override
  State<GardenPage> createState() => _GardenPageState();
}

class _GardenPageState extends State<GardenPage> {
  List sensorList = [];
  final PageController _pageController = PageController(initialPage: 0);
  int pages = 0;

  getSensorData() async {
    // final url =
    //     "https://soilanalysis.loca.lt/v1/sensor/getGardenSensorData/${widget.gardenId}";
    final url =
        "http://localhost:3000/v1/sensor/getGardenSensorData/${widget.gardenId}";

    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.token}'});

    var item = {};
    if (response.statusCode == 200) {
      item = jsonDecode(response.body);
      for (int i = 0; i < item['data'].length; i++) {
        sensorList.add(item['data'][i]);
      }
      pages = item['data'].length;
    }

    setState(() {
      sensorList;
      pages;
    });
  }

  @override
  void initState() {
    super.initState();
    getSensorData();
  }

  @override
  Widget build(BuildContext context) {
    // check dark mode is on
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff4c7750) : const Color(0xff669D6B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const Spacer(),
          // Add sensor button
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.add, size: 30),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),

          //History button
          IconButton(
            onPressed: () => Navigator.push(
                context,
                PageTransition(
                    child: const HistoryPage(),
                    type: PageTransitionType.rightToLeft)),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Text(
              widget.gardenName,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            )),
            const SizedBox(
              height: 10,
            ),

            //Notes
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xff424242) : Colors.white,
                  borderRadius: BorderRadius.circular(12.5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Notes",
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 25),
                    ),
                    Divider(
                      color: isDarkMode ? Colors.white : Colors.black,
                      indent: 5,
                      endIndent: 5,
                      thickness: 2,
                    ),
                    Text(
                      widget.notes,
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Pages
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 550),
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages,
                  itemBuilder: ((context, index) {
                    return _sensor(index, context);
                  })),
            ),

            //Page indicator
            SmoothPageIndicator(
              controller: _pageController,
              count: pages,
              effect: const ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey),
            ),

            //Fertilizer recommendation

            const Divider(),

            const Text("Fertilizer recommendation")
          ],
        ),
      ),
    );
  }

  Widget _sensor(int index, _) {
    var _latestSensor = sensorList[index].last;

    // sensor values
    Map<String, double> npk = {
      'Nitrogen': _latestSensor['nitrogen'].toDouble(),
      'Potassium': _latestSensor['potassium'].toDouble(),
      'Phosphorous': _latestSensor['phosphorous'].toDouble(),
    };

    double ph = _latestSensor['pH'].toDouble(),
        temperature = _latestSensor['temperature'].toDouble(),
        moisture = _latestSensor['temperature'].toDouble(),
        humidity = _latestSensor['humidity'].toDouble();
    //

    double width = MediaQuery.of(_).size.width * 0.49;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        NPKstatus(dataMap: npk, width: MediaQuery.of(_).size.width * 0.9),
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
                Temp(temp: temperature, width: width),

                //
                const SizedBox(
                  height: 10,
                ),

                //Humidity
                Humidity(humidity: humidity, width: width)
              ],
            ),

            //Right Side
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Ph
                PhLevel(ph: ph, width: width),

                //
                const SizedBox(
                  height: 10,
                ),

                //Moisture
                MoistureLevel(moisture: moisture, width: width)
              ],
            )
          ],
        )
      ],
    );
  }
}
