import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Garden and plant card/garden_card.dart';

class MobileHome extends StatelessWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffff0),
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              //* Logo
              SizedBox(
                width: 40,
                height: 40,
                child: SvgPicture.asset("assets/Logo.svg"),
              ),
              const SizedBox(
                height: 10,
              ),

              //* My gardens
              Container(
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
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
              ),

              const SizedBox(
                height: 10,
              ),
//* Garden List
              const GardenList(),
            ],
          ),
        ),
      ),
    );
  }
}

class GardenList extends StatefulWidget {
  const GardenList({Key? key}) : super(key: key);

  @override
  _GardenListState createState() => _GardenListState();
}

class _GardenListState extends State<GardenList> {
  int gardenCount = 2;
  @override
  Widget build(BuildContext context) {
    return
//* Gardens card
        Expanded(
            child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: ListView.builder(
          itemCount: gardenCount < 3 ? gardenCount + 1 : 3,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
//* AddGarden card at the end of the list if gardenCount is less than 3
            if (index == gardenCount && gardenCount < 3) {
              return const AddGarden();
            }
//* if the list is 3, fill all with the garden cards
            return GardenCard(
              status: "good",
              number: index + 1,
            );
          }),
    ));
  }
}
