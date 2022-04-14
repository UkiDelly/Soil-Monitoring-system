// ignore_for_file: must_be_immutable

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Humidity Text
            const Text("Humidity",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            const SizedBox(
              height: 5,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "$humidity",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
              const TextSpan(
                  text: "RH",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))
            ]))
          ],
        ),
      ),
    );
  }
}
