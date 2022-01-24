import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io';

import 'package:thesis/main.dart';

import '../IOS main page.dart';

class Garden extends StatefulWidget {
  const Garden({Key? key}) : super(key: key);

  @override
  _GardenState createState() => _GardenState();
}

class _GardenState extends State<Garden> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        backgroundColor: const Color(0xff669D6B),
        body: SafeArea(
            bottom: false,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  // Header
                  Container(
                    //Space
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),

                          //back button
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: HomePage(),
                                          type:
                                              PageTransitionType.leftToRight));
                                },
                                icon: SvgPicture.asset(
                                  "assets/back.svg",
                                  color: Colors.white,
                                  height: 30,
                                  width: 30,
                                )),
                          ),

                          // My garden text
                          const Hero(
                            tag: "My gardens",
                            child: Text(
                              "My Gardens",
                              style: (TextStyle(
                                  fontFamily: "Readex Pro",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                            ),
                          ),

                          //Space
                          const Flexible(fit: FlexFit.tight,child: SizedBox()),

                          // graph button
                          SizedBox(

                            width: 50,
                            height: 50,
                            child:
                                IconButton(onPressed: () {}, icon: const Icon(Icons.insert_chart_outlined,color: Colors.white,size: 30,)),
                          ),

                          SizedBox(
                            width: 50,
                            height: 50,
                            child: IconButton(onPressed: (){},icon: SvgPicture.asset("assets/setting.svg"),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
