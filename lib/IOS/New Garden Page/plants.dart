import 'package:flutter/material.dart';

class PlantCard extends StatefulWidget {
  const PlantCard({Key? key}) : super(key: key);

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
          InkWell(
            onTap: () => setState(() {
              selectedIndex = 0;
            }),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: selectedIndex == 0
                    ? Border.all(color: Colors.black, width: 5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/plants/rice.png',
                      )),
                  const Text(
                    "Rice",
                    style: TextStyle(fontSize: 50),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: (() => setState(() {
                  selectedIndex = 1;
                })),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: selectedIndex == 1
                    ? Border.all(color: Colors.black, width: 5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/plants/corn.png',
                      )),
                  const Text(
                    "Corn",
                    style: TextStyle(fontSize: 50),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: (() => setState(() {
                  selectedIndex = 2;
                })),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: selectedIndex == 2
                    ? Border.all(color: Colors.black, width: 5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/plants/cassava.png',
                      )),
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
