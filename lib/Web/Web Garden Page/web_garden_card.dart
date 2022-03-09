import 'package:flutter/material.dart';

class WebGardenCard extends StatelessWidget {
  WebGardenCard({Key? key, required this.index}) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff669D6B),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: SizedBox(
          height: 100,
          child: Center(
              child: Stack(
            children: [
              //* Index of the list
              Positioned(
                child: Text(
                  "#$index",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
                top: 10,
                left: 20,
              ),

              //* Garden Name
            ],
          ))),
    );
  }
}
