import 'package:flutter/material.dart';

class MoistureLevel extends StatefulWidget {
  double moisture;
  MoistureLevel({Key? key, required this.moisture}) : super(key: key);

  @override
  _MoistureLevelState createState() => _MoistureLevelState();
}

class _MoistureLevelState extends State<MoistureLevel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("Moisture",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          RichText(
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
          ]))
        ]),
      ),
    );
  }
}
