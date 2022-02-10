import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Temp extends StatefulWidget {
  var temp;
  Temp({Key? key, this.temp}) : super(key: key);

  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Tempurature",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          OpacityAnimatedWidget(
            delay: const Duration(milliseconds: 2000),
            curve: Curves.ease,
            duration: const Duration(seconds: 1),
            enabled: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientText(
                  "${widget.temp}",
                  colors: getColor(widget.temp),
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const Text("°C",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 170,
            child: SfLinearGauge(
              showTicks: false,
              animationDuration: 3000,
              animateRange: true,
              animateAxis: true,
              barPointers: [
                LinearBarPointer(
                  value: widget.temp,
                  color: Colors.red,
                )
              ],
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
    );
  }
}

getColor(temp) {
  List<Color> color;
  if (temp < 25) {
    return color = const [Color(0xff2196EB), Color(0xff5482C0)];
  } else if (temp < 50) {
    return color = const [Color(0xff5482C0), Color(0xff8F6B8D)];
  } else if (temp < 75) {
    return color = const [Color(0xff8F6B8D), Color(0xffCC5359)];
  } else {
    return color = const [Color(0xffCC5359), Color(0xffF44336)];
  }
}
