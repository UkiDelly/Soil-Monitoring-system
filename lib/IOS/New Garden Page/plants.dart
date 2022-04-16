import 'package:flutter/material.dart';

class PlantCard extends StatefulWidget {
  const PlantCard({Key? key}) : super(key: key);

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
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
          Container(
            width: 375,
            height: 350,
            decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            width: 375,
            height: 350,
            decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            width: 375,
            height: 350,
            decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }
}
