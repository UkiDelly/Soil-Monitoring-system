// ignore_for_file: must_be_immutable

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Temp extends StatefulWidget {
  double temp;
  Temp({Key? key, required this.temp}) : super(key: key);

  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 125,
      child: Card(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Temperature text
            const Text("Temperature",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            // Opacity animation
            OpacityAnimatedWidget(
              delay: const Duration(milliseconds: 2000),
              curve: Curves.ease,
              duration: const Duration(seconds: 1),
              enabled: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gradient Text
                  GradientText(
                    "${widget.temp}",
                    colors: getColor(widget.temp),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Text("°C",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            /// Linear gauge
            SizedBox(
              width: 160,
              child: SfLinearGauge(
                showTicks: false,
                animationDuration: 3000,
                animateRange: true,
                animateAxis: true,
                // Gauge division
                barPointers: [
                  LinearBarPointer(
                    value: widget.temp,
                    color: Colors.red,
                  )
                ],

                /// Mark Pointer
                markerPointers: [
                  LinearShapePointer(
                    value: widget.temp,
                    color: Colors.redAccent,
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

/// Colors for the gradient text
List<Color> getColor(temp) {
  if (temp < 25) {
    return const [Color(0xff2196EB), Color(0xff5482C0)];
  } else if (temp < 50) {
    return const [Color(0xff5482C0), Color(0xff8F6B8D)];
  } else if (temp < 75) {
    return const [Color(0xff8F6B8D), Color(0xffCC5359)];
  } else {
    return const [Color(0xffCC5359), Color(0xffF44336)];
  }
}
