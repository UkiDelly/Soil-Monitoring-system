// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/IOS/Gardens%20Page/Garden%20Page%20widgets/humidity.dart';
import 'package:thesis/IOS/Gardens%20Page/Garden%20Page%20widgets/moisture.dart';
import 'package:thesis/IOS/Gardens%20Page/Garden%20Page%20widgets/npk_status.dart';
import 'package:thesis/IOS/Gardens%20Page/Garden%20Page%20widgets/ph_level.dart';
import 'package:thesis/IOS/Gardens%20Page/Garden%20Page%20widgets/tempurature.dart';
import 'package:thesis/Main/loading.dart';
import 'package:thesis/provider.dart';
import 'package:http/http.dart' as http;

class WebGarden extends ConsumerWidget {
  WebGarden({
    Key? key,
  }) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokenProvider);
    final gardenID = ref.watch(gardenIDProvider);

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
              ))
          : Opacity(
              opacity: 0.25,
              child: Center(child: Image.asset('Logo/Logo.png'))),
    );
  }
}

class _Status extends StatefulWidget {
  String token, gardenID;
  _Status({Key? key, required this.token, required this.gardenID})
      : super(key: key);

  @override
  State<_Status> createState() => __StatusState();
}

class __StatusState extends State<_Status> {
  // var

  Map<String, double> sampleNPK = {
    "Nutrient": 20,
    "Potassium": 25,
    "Phosphorus": 40
  };
  double ph = 7.5;
  double temp = 99.9;
  double moisture = 0.1;
  double humidity = 30;
  bool isLoading = false;
  dynamic _garden = {};

  getSingleGarden() async {
    // final url = "https://soilanalysis.loca.lt/v1/garden/get/$gardenID";
    final url = "http://localhost:3000/v1/garden/get/${widget.gardenID}";
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer ${widget.token}',
    });
    var item = jsonDecode(response.body);
    return item;
  }

  @override
  void initState() {
    super.initState();
    _garden = getSingleGarden();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _garden,
        builder: (BuildContext context, AsyncSnapshot<dynamic> garden) {
          if (!garden.hasData) {
            return const LoadingPage();
          }
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
            child: Card(
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
                            garden.data['data']['name'],
                            style: const TextStyle(fontSize: 35),
                          ))),
                  // Status
                  Wrap(
                    children: [
                      OpacityAnimatedWidget(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(seconds: 1),
                          enabled: true,
                          child: NPKstatus(dataMap: sampleNPK)),

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
                  const SizedBox(
                    height: 500,
                  )

                  //
                ],
              ),
            ),
          );
        }
        //

        );
  }
}

// If the width is less tha 550
class WebGardenMini extends StatelessWidget {
  bool isTapped;
  WebGardenMini({Key? key, required this.isTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebGarden(

          //gardenID: gardenID,
          ),
    );
  }
}
