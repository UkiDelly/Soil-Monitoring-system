// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GardenName extends StatelessWidget {
  TextEditingController controller;
  String name;
  bool isSettingPressed;
  GardenName(
      {Key? key,
      required this.name,
      required this.isSettingPressed,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: const Color(0xfffffff0),
          boxShadow: [
            BoxShadow(
                color: Colors.green.shade400,
                offset: const Offset(-4, -4),
                blurRadius: 10),
            BoxShadow(
                color: Colors.green.shade900,
                offset: const Offset(4, 4),
                blurRadius: 10),
          ]),
      child: Center(
        child: isSettingPressed == false
            ? Text(
                name,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    hintText: name,
                    hintStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                  controller: controller,
                ),
              ),
      ),
    );
  }
}