import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thesis/Garden%20and%20plant%20card/Card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    int gardenCount;
    int plantCount;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          // const SizedBox(
          //   height: 10,
          // ),

          // Logo
          SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset("assets/Logo.svg"),
          ),
          const SizedBox(
            height: 10,
          ),

          // My gardens
          Container(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              child: Row(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: const [
                      SizedBox(
                        width: 25,
                      ),
                      Hero(
                        tag: "My gardens",
                        child: Text(
                          "My Gardens",
                          style: (TextStyle(
                              fontFamily: "Readex Pro",
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Gardens card
          SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GardenAndPlantCard(
                      gardenOrPlant: 1,
                    );
                  })),

          // Plants
          Container(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              child: Row(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      const Text(
                        "Plants",
                        style: (TextStyle(
                            fontFamily: "Readex Pro",
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      SizedBox(
                        child: SvgPicture.asset("assets/setting_2.svg"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

          //Plants card
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.8,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GardenAndPlantCard();
                }),
          ),

          //Bottom bar
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
