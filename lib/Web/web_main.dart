import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/login.dart';

import 'Web Garden Page/web_garden_card.dart';
import 'Web Garden Page/web_garden_page.dart';

class WebMain extends StatefulWidget {
  const WebMain({Key? key}) : super(key: key);

  @override
  _WebMainState createState() => _WebMainState();
}

class _WebMainState extends State<WebMain> {
  int gardenCount = 2;
  bool isPressed = false;
  var indexTapped = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffff0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => setState(() {
              isPressed = false;
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //? Logo and Name
                SizedBox(
                  child: Row(
                    children: [
                      //* Logo
                      SvgPicture.asset("assets/Logo.svg"),

                      //
                      const SizedBox(
                        width: 20,
                      ),

                      //* My Gardens
                      const Text(
                        "My Gardens",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Readex Pro"),
                      ),

                      //* Logout
                      const Expanded(child: SizedBox()),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: const LoginPage(),
                                    type: PageTransitionType.fade));
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ))
                    ],
                  ),
                ),

                //
                const SizedBox(
                  height: 20,
                ),

                //* Garden Card
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: isPressed == false ? 300 : 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: ListView.builder(
                      itemCount: gardenCount < 3 ? gardenCount + 1 : 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        //* AddGarden card at the end of the list if gardenCount is less than 3
                        if (index == gardenCount && gardenCount < 3) {
                          return WebAddGarden(
                            isPressed: isPressed,
                          );
                        }
                        //* if the list is 3, fill all with the garden cards
                        return InkWell(
                          //* Detect if it card is pressed
                          onTap: () => setState(() {
                            isPressed = true;
                            indexTapped = index + 1;
                          }),
                          //* Garden cards
                          child: WebGardenCard(
                            isPressed: isPressed,
                            status: "good",
                            number: index + 1,
                            indexTapped: indexTapped,
                          ),
                        );
                      }),
                ),

                const SizedBox(
                  height: 20,
                ),

                //* Container when pressed
                AnimatedContainer(
                  curve: Curves.easeInToLinear,
                  duration: const Duration(milliseconds: 200),
                  width: MediaQuery.of(context).size.width - 20,
                  height: isPressed != false ? 800 : 0,
                  decoration: const BoxDecoration(
                      color: Color(0xff669D6B),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: isPressed == true
                      //* Garden Page
                      ? WebGardenPage(
                          isPressed: isPressed, indexTapped: indexTapped)
                      : null,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
