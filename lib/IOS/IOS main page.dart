import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Garden and plant card/Garden card.dart';
import 'Garden and plant card/Plant card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    int gardenCount = 4;
    int plantCount;
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
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
                          transitionOnUserGestures: true,
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
                    itemCount: gardenCount,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < gardenCount - 1) {
                        return GardenCard();
                      }
                      return const AddGarden();
                    })),

            // Plants
            Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                child: Row(
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
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    SizedBox(
                      child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {},
                          icon: SvgPicture.asset("assets/setting.svg")),
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
                    return PlantCard();
                  }),
            ),

            //Bottom bar
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
