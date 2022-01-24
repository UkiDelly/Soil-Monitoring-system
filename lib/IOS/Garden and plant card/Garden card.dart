import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page.dart';

class GardenCard extends StatefulWidget {
  const GardenCard({Key? key}) : super(key: key);

  @override
  _GardenCardState createState() => _GardenCardState();
}

class _GardenCardState extends State<GardenCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      // Card
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: const Color(0xff669D6B),
        child: InkWell(
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (builder) => Garden())),
          child: SizedBox(
            width: 200,
            child: Stack(
              children: [
                Positioned(
                    top: 15,
                    left: 17,
                    width: 125,
                    child: Text("#1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Readex Pro",
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
                Positioned(
                  top: 8,
                  right: 10,
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      // if there is laking, use warning
                      child: SvgPicture.asset(
                        "assets/check.svg",
                        color: Colors.white,
                      )),
                ),
                const Positioned(
                    width: 100,
                    right: 10,
                    top: 70,
                    child: Text(
                        "Summary of the status of the soil and comment will be display here!~~"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddGarden extends StatelessWidget {
  const AddGarden({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      // Card
      child: GestureDetector(
        //When Tap, go to the detail page
        onTap: () {},
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: Colors.white,
          child: SizedBox(
            width: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Add New Garden",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Readex Pro"))
                ],
              ),
            ),
            //child: ,
          ),
        ),
      ),
    );
  }
}
