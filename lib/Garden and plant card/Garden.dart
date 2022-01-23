import 'package:flutter/material.dart';
import 'package:thesis/Gardens/Garden%20Page.dart';

class GardenCard extends StatefulWidget {
  GardenCard({Key? key}) : super(key: key);

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
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (builder) => Garden())),
          child: Container(
            width: 200,
            //child: ,
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
