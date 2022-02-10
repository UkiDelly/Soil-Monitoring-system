import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PhLevel extends StatefulWidget {
  var ph;
  PhLevel({Key? key, this.ph}) : super(key: key);

  @override
  _PhLevelState createState() => _PhLevelState();
}

class _PhLevelState extends State<PhLevel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 70,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Ph Level",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            GradientText(
              "${widget.ph}",
              colors: getColor(widget.ph),
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
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
