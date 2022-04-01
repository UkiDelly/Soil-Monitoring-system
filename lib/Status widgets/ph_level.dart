// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

getColor(double ph) {
  late List<Color> color;

  if (ph < 3) {
    color = [Colors.red, Colors.red];
    return color;
  } else if (ph < 6) {
    color = [Colors.orange, Colors.yellow];
    return color;
  } else if (ph == 7) {
    color = [Colors.green, Colors.lightGreen];
    return color;
  } else if (ph > 7 && ph < 11) {
    color = [Colors.blue, Colors.purple];
    return color;
  } else {
    color = [Colors.purple, Colors.indigo];
    return color;
  }
}

class PhLevel extends StatelessWidget {
  double ph;
  PhLevel({Key? key, required this.ph}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10)),

            const Text("Ph Level",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            //
            //
            SizedBox(
              height: 130,

              /// Ph Level gauge
              child: SfRadialGauge(
                // loading animation
                enableLoadingAnimation: true,
                animationDuration: 2000,
                axes: <RadialAxis>[
                  // Axis
                  RadialAxis(
                    // minimum value of the gauge
                    minimum: 0,
                    // maximum value of the gauge
                    maximum: 14,
                    // start angle of the gauge
                    startAngle: 180,
                    // end angle of the gauge
                    endAngle: 0,
                    canScaleToFit: true,
                    showAxisLine: false,
                    // show the first label of the gauge
                    showFirstLabel: true,
                    // show the last label of the gauge
                    showLastLabel: true,
                    // distance between the label and the gauge
                    labelOffset: 8,
                    showTicks: false,

                    // label style
                    axisLabelStyle:
                        const GaugeTextStyle(fontWeight: FontWeight.bold),

                    // gauge settings
                    ranges: [
                      GaugeRange(
                        startValue: 0,
                        endValue: 3,
                        color: Colors.red,
                        gradient: const SweepGradient(colors: [
                          Colors.red,
                          Colors.orange,
                        ]),
                      ),
                      GaugeRange(
                        startValue: 3,
                        endValue: 6,
                        gradient: const SweepGradient(colors: [
                          Colors.orange,
                          Colors.yellow,
                        ]),
                      ),
                      GaugeRange(
                        startValue: 6,
                        endValue: 7,
                        gradient: const SweepGradient(colors: [
                          Colors.yellow,
                          Colors.green,
                        ]),
                      ),
                      GaugeRange(
                        startValue: 7,
                        endValue: 11,
                        gradient: const SweepGradient(
                            colors: [Colors.green, Colors.blue]),
                      ),
                      GaugeRange(
                        startValue: 11,
                        endValue: 14,
                        gradient: const SweepGradient(
                            colors: [Colors.blue, Colors.purple]),
                      ),
                    ],

                    // Pointer of the gauge
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        animationDuration: 2000,
                        value: ph,
                        markerOffset: -10,
                        color: Colors.black,
                        enableAnimation: true,
                        animationType: AnimationType.ease,
                      )
                    ],

                    // Widget showing in the center of the gauge widget
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          horizontalAlignment: GaugeAlignment.center,
                          angle: 90,
                          widget: SizedBox(
                              child: GradientText(
                            "$ph",
                            colors: getColor(ph),
                            style: const TextStyle(
                                fontSize: 45, fontWeight: FontWeight.bold),
                          )))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
