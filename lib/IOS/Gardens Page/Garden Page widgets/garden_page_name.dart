// ignore_for_file: must_be_immutable

import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';

class GardenName extends StatelessWidget {
  String name;

  GardenName({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TranslationAnimatedWidget.tween(
        duration: const Duration(seconds: 1),
        enabled: true,
        translationDisabled: const Offset(0, -150),
        translationEnabled: const Offset(0, 0),
        curve: Curves.fastOutSlowIn,
        child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: const Color.fromARGB(255, 246, 245, 245),
                boxShadow: [
                  BoxShadow(
                      color: Colors.green.shade200,
                      offset: const Offset(-4, -4),
                      blurRadius: 10),
                  BoxShadow(
                      color: Colors.green.shade900,
                      offset: const Offset(4, 4),
                      blurRadius: 10),
                ]),
            child: Center(
              child: OpacityAnimatedWidget.tween(
                duration: const Duration(seconds: 1),
                enabled: true,
                opacityDisabled: 0,
                opacityEnabled: 1,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            )));
  }
}
