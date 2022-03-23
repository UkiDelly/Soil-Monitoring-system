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
import 'package:thesis/loading.dart';
import 'package:thesis/provider.dart';
import 'package:http/http.dart' as http;

class WebGarden extends StatelessWidget {
  bool isTapped;

  WebGarden({Key? key, required this.isTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: isTapped
          ? const SingleChildScrollView(child: _Status())
          : Opacity(opacity: 0.25, child: Image.asset('Logo/Logo.png')),
    );
  }
}

class _Status extends ConsumerStatefulWidget {
  const _Status({Key? key}) : super(key: key);

  @override
  ConsumerState<_Status> createState() => __StatusState();
}

class __StatusState extends ConsumerState<_Status> {
  // var

  Map<String, double> sampleNPK = {"n": 20, "p": 25, "k": 40};
  double ph = 7.5;
  double temp = 99.9;
  double moisture = 0.1;
  double humidity = 30;
  bool isLoading = false;
  late Future<dynamic> _garden;
  //
  getSingleGarden() async {
    final token = ref.watch(tokenProvider);
    final gardenID = ref.watch(gardenIDProvider);
    // final url = "https://soilanalysis.loca.lt/v1/garden/get/$gardenID";
    final url = "http://localhost:3000/v1/garden/get/$gardenID";
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    var item = jsonDecode(response.body);
    return item;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _garden = getSingleGarden();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _garden,
        builder: (BuildContext context, AsyncSnapshot<dynamic> garden) {
          if (garden.hasData) {
            return Card(
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
                      child: Wrap(children: [
                        Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 246, 245, 245),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(
                              garden.data['data']['name'],
                              style: const TextStyle(fontSize: 35),
                            )),
                      ])),
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

                  //
                  const SizedBox(
                    height: 500,
                  )

                  //
                ],
              ),
            );
          } else {
            return const LoadingPage();
          }
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
        isTapped: isTapped,

        //gardenID: gardenID,
      ),
    );
  }
}
