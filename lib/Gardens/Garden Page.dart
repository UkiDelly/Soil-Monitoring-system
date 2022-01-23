import 'package:flutter/material.dart';

class Garden extends StatefulWidget {
  const Garden({Key? key}) : super(key: key);

  @override
  _GardenState createState() => _GardenState();
}

class _GardenState extends State<Garden> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff669D6B),
      body: SafeArea(
          bottom: false,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
          )),
    );
  }
}
