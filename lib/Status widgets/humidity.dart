// ignore_for_file: must_be_immutable

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';

class Humidity extends StatelessWidget {
  double humidity, width;
  Humidity({Key? key, required this.humidity, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //180
      width: width,
      height: 80,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: OpacityAnimatedWidget(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 1000),
          enabled: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Humidity Text
              const Text("Humidity",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$humidity",
                    style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "RH",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
