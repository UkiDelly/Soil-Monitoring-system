import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/Gardens%20Page/Garden%20Page%20widgets/humidity.dart';
import 'package:thesis/IOS/Gardens%20Page/Garden%20Page%20widgets/moisture.dart';
import 'package:thesis/IOS/Gardens%20Page/Garden%20Page%20widgets/npk_status.dart';
import 'package:thesis/IOS/Gardens%20Page/Garden%20Page%20widgets/ph_level.dart';
import 'package:thesis/IOS/Gardens%20Page/Garden%20Page%20widgets/tempurature.dart';

class WebGarden extends StatefulWidget {
  bool isTapped;
  WebGarden({Key? key, required this.isTapped}) : super(key: key);

  @override
  State<WebGarden> createState() => _WebGardenState();
}

class _WebGardenState extends State<WebGarden> {
  // var
  Map sampledata = {"name": "afadfsdfsfsdfsdfdfdfdfsfs"};
  Map<String, double> sampleNPK = {"n": 20, "p": 25, "k": 40};
  double ph = 7.5;
  double temp = 99.9;
  double moisture = 0.1;
  double humidity = 30;
  //
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: widget.isTapped
            ? SingleChildScrollView(
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
                            child: gardenName()),
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
                    )),
              )
            : Opacity(opacity: 0.25, child: Image.asset('Logo/Logo.png')));
  }

  Widget gardenName() {
    return Flexible(
      child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 246, 245, 245),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            sampledata["name"],
            style: const TextStyle(fontSize: 35),
          )),
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
      body: WebGarden(isTapped: isTapped),
    );
  }
}
