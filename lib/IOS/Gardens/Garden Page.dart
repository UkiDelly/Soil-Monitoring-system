import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/Gardens/History%20Page.dart';
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
            child: SizedBox(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Head
                  Header(),

                  // Body
                  Container(
                    height: 375,
                  ),

                  // Bottom
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xfffefefe),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 5,
                              blurRadius: 30,
                              offset: const Offset(0, 10))
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

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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

                  // go back to the main page
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    "assets/back.svg",
                    color: Colors.white,
                    height: 30,
                    width: 30,
                  )),
            ),

            // My garden name text
            const Hero(
              tag: "Garden Number",
              child: Text(
                "My Gardens",
                style: (TextStyle(
                    fontFamily: "Readex Pro",
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
              ),
            ),

            //Space
            const Flexible(fit: FlexFit.tight, child: SizedBox()),

            // analysist button
            SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            duration: const Duration(milliseconds: 595),
                            child: HistoryPage(),
                            type: PageTransitionType.rightToLeft));
                  },
                  icon: const Icon(
                    Icons.insert_chart_outlined,
                    color: Colors.white,
                    size: 30,
                  )),
            ),

            // setting of the gard page
            SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("assets/setting.svg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
