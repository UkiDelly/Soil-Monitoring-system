import 'package:flutter/material.dart';

class GardenInfo extends StatelessWidget {
  final String gardenName, notes;
  final isDarkMode;
  const GardenInfo(
      {Key? key,
      required this.gardenName,
      required this.isDarkMode,
      required this.notes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
          gardenName,
          style: const TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
        )),
        const SizedBox(
          height: 10,
        ),

        //Notes
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff424242) : Colors.white,
                borderRadius: BorderRadius.circular(12.5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "notes",
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 17),
                    ),
                  ),
                  Divider(
                    color: isDarkMode ? Colors.white : Colors.black,
                    indent: 5,
                    endIndent: 5,
                    thickness: 2,
                  ),
                  Text(
                    notes,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
