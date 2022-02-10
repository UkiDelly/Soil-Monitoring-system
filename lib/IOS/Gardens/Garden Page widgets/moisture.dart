import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Moisture_Level extends StatefulWidget {
  var moisture;
  Moisture_Level({Key? key, required this.moisture}) : super(key: key);

  @override
  _Moisture_LevelState createState() => _Moisture_LevelState();
}

class _Moisture_LevelState extends State<Moisture_Level> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 130,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Text("Moisture",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        OpacityAnimatedWidget(
          delay: const Duration(milliseconds: 2000),
          curve: Curves.ease,
          duration: const Duration(seconds: 1),
          enabled: true,
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "${widget.moisture}",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const TextSpan(
              text: "%",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            )
          ])),
        ),
        SizedBox(
          width: 170,
          child: SfLinearGauge(
            showTicks: false,
            animationDuration: 3000,
            animateRange: true,
            barPointers: [LinearBarPointer(value: widget.moisture)],
            markerPointers: [
              LinearShapePointer(
                value: widget.moisture,
                color: Colors.blueAccent,
              )
            ],
          ),
        )
      ]),
    );
  }
}
