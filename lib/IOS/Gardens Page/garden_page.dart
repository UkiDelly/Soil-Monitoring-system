import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thesis/IOS/Gardens%20Page/fertilizer.dart';
import 'package:http/http.dart' as http;
import 'package:thesis/Main/loading.dart';
import 'package:thesis/Status%20widgets/humidity.dart';
import 'package:thesis/Status%20widgets/moisture.dart';
import 'package:thesis/Status%20widgets/npk_status.dart';
import 'package:thesis/Status%20widgets/ph_level.dart';
import 'package:thesis/Status%20widgets/tempurature.dart';
import 'package:thesis/data_classes.dart';

import '../History Page/history_page.dart';

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
  final PageController _pageController = PageController(initialPage: 0);
  int pages = 1;
  var getData;
  List<HistoryOfSensorData> history = [];

  getSensorData() async {
    // final url =
    //     "https://soilanalysis.loca.lt/v1/sensor/getGardenSensorData/${widget.gardenId}";
    final url =
        "http://localhost:3000/v1/sensor/getGardenSensorData/${widget.gardenId}";

    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.token}'});

    var item = {};
    List _sensorList = [];
    if (response.statusCode == 200) {
      item = jsonDecode(response.body);
      for (int i = 0; i < item['data'].length; i++) {
        _sensorList.add(item['data'][i]);
      }
      pages = item['data'].length;
      for (int i = 0; i < pages; i++) {
        history.add(HistoryOfSensorData(_sensorList[i]));
        history[i].createHistory();
      }
    }

    setState(() {
      history;
      pages;
    });
    return _sensorList;
  }

  @override
  void initState() {
    super.initState();
    getData = getSensorData();
  }

  @override
  Widget build(BuildContext context) {
    // check dark mode is on
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff4c7750) : const Color(0xff669D6B),

      extendBodyBehindAppBar: true,
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
          child: FutureBuilder(
            future: getData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LoadingPage(),
                );
              } else if (!snapshot.hasData || snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              //Conver object to list
              var _sensorList = snapshot.data as List;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    widget.gardenName,
                    style: const TextStyle(
                        fontSize: 33, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(
                    height: 10,
                  ),

                  //Notes
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xff424242)
                              : Colors.white,
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
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
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
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //Pages
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

                  const SizedBox(
                    height: 10,
                  ),

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
                  const FertilizerCards()
                ],
              );
            },
          ),
        ),
      ),
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
        const SizedBox(
          height: 10,
        ),
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
}
