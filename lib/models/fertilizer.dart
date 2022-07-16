import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Plants/cassave.dart';
import 'Plants/corn.dart';
import 'Plants/rice.dart';

// ignore: must_be_immutable
class FertilizerCards extends StatefulWidget {
  double nAverage, pAverage, kAverage, phAverage;
  String plant;
  FertilizerCards(
      {Key? key,
      required this.nAverage,
      required this.pAverage,
      required this.kAverage,
      required this.phAverage,
      required this.plant})
      : super(key: key);

  @override
  State<FertilizerCards> createState() => _FertilizerCardsState();
}

class _FertilizerCardsState extends State<FertilizerCards> {
  var matrix;
  List status = [];
  List fertilizer = [];

  // identify the plant and get the fertilizer recommendation.
  getRecommendation() {
    switch (widget.plant) {
      case "Rice":
        matrix = Rice(
            nitrogen: widget.nAverage,
            phosphorous: widget.pAverage,
            potassium: widget.kAverage,
            ph: widget.phAverage);
        status.add(matrix.getNitrogen()['status']);
        fertilizer.add(matrix.getNitrogen()['fertilizer']);
        status.add(matrix.getPhosphorous()['status']);
        fertilizer.add(matrix.getPhosphorous()['fertilizer']);
        status.add(matrix.getPotassium()['status']);
        fertilizer.add(matrix.getPotassium()['fertilizer']);

        fertilizer.add(matrix.getPh());

        break;
      case "Corn":
        matrix = Corn(
            nitrogen: widget.nAverage,
            phosphorous: widget.pAverage,
            potassium: widget.kAverage,
            ph: widget.phAverage);
        status.add(matrix.getNitrogen()['status']);
        fertilizer.add(matrix.getNitrogen()['fertilizer']);
        status.add(matrix.getPhosphorous()['status']);
        fertilizer.add(matrix.getPhosphorous()['fertilizer']);
        status.add(matrix.getPotassium()['status']);
        fertilizer.add(matrix.getPotassium()['fertilizer']);

        fertilizer.add(matrix.getPh());
        break;

      case "Cassava":
        matrix = Cassave(
            nitrogen: widget.nAverage,
            phosphorous: widget.pAverage,
            potassium: widget.kAverage,
            ph: widget.phAverage);
        status.add(matrix.getNitrogen()['status']);
        fertilizer.add(matrix.getNitrogen()['fertilizer']);
        status.add(matrix.getPhosphorous()['status']);
        fertilizer.add(matrix.getPhosphorous()['fertilizer']);
        status.add(matrix.getPotassium()['status']);
        fertilizer.add(matrix.getPotassium()['fertilizer']);
        fertilizer.add(matrix.getPh());
    }

    setState(() {
      matrix;
      status;
      fertilizer;
    });
  }

  @override
  void initState() {
    getRecommendation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // check dark mode is on
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),

            // Notrigen
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: isDarkMode ? const Color(0xff424242) : Colors.white,
              elevation: 5,
              child: SizedBox(
                width: 300,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Nitrogen", style: TextStyle(fontSize: 30)),
                    const Spacer(),
                    const Text(
                      "46-0-0(UREA)",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text("Status : ${status[0]}",
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    const Text("Amount recommended",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(" Wet season: ${fertilizer[0]['wet']}",
                        style: const TextStyle(
                            fontSize: 20, color: Colors.blueAccent)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(" Dry season: ${fertilizer[0]['dry']}",
                        style: const TextStyle(
                            fontSize: 20, color: Colors.orangeAccent)),
                    const Spacer(
                      flex: 2,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),

            // Phosphorous
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: isDarkMode ? const Color(0xff424242) : Colors.white,
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 300,
                height: 400,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Phosphorous", style: TextStyle(fontSize: 30)),
                    const Spacer(),
                    const Text(
                      "0-18-0 (SUPER PHOSPATE)",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text("Status : ${status[1]}",
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    const Text("Amount recommended",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(" Wet season: ${fertilizer[1]['wet']}",
                        style: const TextStyle(
                            fontSize: 20, color: Colors.blueAccent)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(" Dry season: ${fertilizer[1]['dry']}",
                        style: const TextStyle(
                            fontSize: 20, color: Colors.orangeAccent)),
                    const Spacer(
                      flex: 2,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),

            // Potassium
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: isDarkMode ? const Color(0xff424242) : Colors.white,
              elevation: 5,
              child: SizedBox(
                width: 300,
                height: 400,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Potassium", style: TextStyle(fontSize: 30)),
                    const Spacer(),
                    const Text(
                      "0-0-60 (MURIATE OF POTASH)",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text("Status : ${status[0]}",
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    const Text("Amount recommended",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(" Wet season: ${fertilizer[2]['wet']}",
                        style: const TextStyle(
                            fontSize: 20, color: Colors.blueAccent)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(" Dry season: ${fertilizer[2]['dry']}",
                        style: const TextStyle(
                            fontSize: 20, color: Colors.orangeAccent)),
                    const Spacer(
                      flex: 2,
                    )
                  ],
                ),
              ),
            ),

            // Ph
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: isDarkMode ? const Color(0xff424242) : Colors.white,
              elevation: 5,
              child: SizedBox(
                width: 300,
                height: 400,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("PH", style: TextStyle(fontSize: 30)),
                    const Spacer(),
                    const Text(
                      "ORGANIC FERTILIZIER",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    const Text("Amount recommended",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30)),
                    const SizedBox(
                      height: 10,
                    ),
                    GradientText("${fertilizer[3]}",
                        style: const TextStyle(fontSize: 20),
                        colors: const [Colors.blueAccent, Colors.orangeAccent]),
                    const Spacer(
                      flex: 2,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
