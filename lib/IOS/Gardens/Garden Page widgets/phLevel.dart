import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Ph_Level extends StatefulWidget {
  double ph;
  Ph_Level({Key? key, required this.ph}) : super(key: key);

  @override
  _Ph_LevelState createState() => _Ph_LevelState();
}

class _Ph_LevelState extends State<Ph_Level> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),

          const Text("Ph Level",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          //
          //
          SizedBox(
            height: 150,
            child: SfRadialGauge(
              enableLoadingAnimation: true,
              animationDuration: 2000,
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 14,
                  startAngle: 180,
                  endAngle: 0,
                  canScaleToFit: true,
                  showAxisLine: false,
                  showFirstLabel: true,
                  showLastLabel: true,
                  labelOffset: 8,
                  showTicks: false,
                  axisLabelStyle:
                      const GaugeTextStyle(fontWeight: FontWeight.bold),
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
                  pointers: <GaugePointer>[
                    MarkerPointer(
                      animationDuration: 2000,
                      value: widget.ph,
                      markerOffset: -10,

                      // animationType: AnimationType.,
                      color: Colors.black,
                      enableAnimation: true,
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        horizontalAlignment: GaugeAlignment.center,
                        angle: 90,
                        widget: SizedBox(
                            child: GradientText(
                          "${widget.ph}",
                          colors: getColor(widget.ph),
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
    );
  }
}

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
