import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Garden and plant card/garden_card.dart';
import 'Garden and plant card/plant_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    int gardenCount = 4;
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
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
                        Text(
                          "My Gardens",
                          style: (TextStyle(
                              fontFamily: "Readex Pro",
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
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
                        //test status
                        if (index == 0) {
                          return GardenCard(
                            number: index + 1,
                            status: "good",
                          );
                        } else {
                          return GardenCard(
                            number: index + 1,
                            status: "warning",
                          );
                        }
                      }
                      // Add new garden card
                      return const AddGarden();
                    })),

            // Plants
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: const [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Plants",
                    style: (TextStyle(
                        fontFamily: "Readex Pro",
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
                  ),
                ],
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
