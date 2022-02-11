import 'package:flutter/material.dart';

class Humidity extends StatefulWidget {
  var humidity;
  Humidity({Key? key, this.humidity}) : super(key: key);

  @override
  _HumidityState createState() => _HumidityState();
}

class _HumidityState extends State<Humidity> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
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
                  text: "${widget.humidity}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black)),
              const TextSpan(
                  text: "RH",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black))
            ]))
          ],
        ),
      ),
    );
  }
}
