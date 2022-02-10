import 'package:flutter/material.dart';

class GardenName extends StatefulWidget {
  var isSettingPressed, gardenName, nameControl;
  GardenName(
      {Key? key, this.isSettingPressed, this.gardenName, this.nameControl})
      : super(key: key);

  @override
  _GardenNameState createState() => _GardenNameState();
}

class _GardenNameState extends State<GardenName> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
          height: 50,
          padding: const EdgeInsets.all(8),

          // if edit buttom is not pressed
          child: widget.isSettingPressed == false
              ? Text(
                  widget.gardenName,
                  style: const TextStyle(
                      fontFamily: "Readex Pro",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              //if edit buttom ispressed
              : SizedBox(
                  width: 100,
                  child: TextField(
                    style: const TextStyle(fontSize: 15),
                    controller: widget.nameControl,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: widget.gardenName,
                    ),
                  ),
                )),
    );
  }
}
