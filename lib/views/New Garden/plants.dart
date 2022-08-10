import 'package:flutter/material.dart';

import '../../models/enum.dart';

class PlantCard extends StatefulWidget {
  final Function(Plant plant) callback;
  const PlantCard({Key? key, required this.callback}) : super(key: key);

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    // check dark mode is on
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          //
          InkWell(
            onTap: () => setState(() {
              //when click, select this plant and call the callback to get the name
              selectedIndex = 0;
              widget.callback(Plant.rice);
            }),

            //* Rice
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: selectedIndex == 0
                    ? Border.all(
                        color: isDarkMode ? Colors.white : Colors.black,
                        width: 5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/plants/rice.png',
                      )),

                  //
                  const Text(
                    "Rice",
                    style: TextStyle(fontSize: 50),
                  )
                ],
              ),
            ),
          ),

          //
          const SizedBox(
            width: 15,
          ),

          //
          InkWell(
            onTap: (() => setState(() {
                  //when click, select this plant and call the callback to get the name
                  selectedIndex = 1;
                  widget.callback(Plant.corn);
                })),

            //* Corn
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: selectedIndex == 1
                    ? Border.all(
                        color: isDarkMode ? Colors.white : Colors.black,
                        width: 5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/plants/corn.png',
                      )),
                  //
                  const Text(
                    "Corn",
                    style: TextStyle(fontSize: 50),
                  )
                ],
              ),
            ),
          ),

          //
          const SizedBox(
            width: 15,
          ),

          //
          InkWell(
            onTap: (() => setState(() {
                  selectedIndex = 2;
                  widget.callback(Plant.cassava);
                })),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: selectedIndex == 2
                    ? Border.all(
                        color: isDarkMode ? Colors.white : Colors.black,
                        width: 5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/plants/cassava.png',
                      )),

                  //
                  const Text(
                    "Cassava",
                    style: TextStyle(fontSize: 50),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
