import 'package:flutter/material.dart';

class FertilizerCards extends StatefulWidget {
  const FertilizerCards({Key? key}) : super(key: key);

  @override
  State<FertilizerCards> createState() => _FertilizerCardsState();
}

class _FertilizerCardsState extends State<FertilizerCards> {
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
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: isDarkMode ? const Color(0xff424242) : Colors.white,
              elevation: 5,
              child: const SizedBox(
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: isDarkMode ? const Color(0xff424242) : Colors.white,
              elevation: 5,
              child: const SizedBox(
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: isDarkMode ? const Color(0xff424242) : Colors.white,
              elevation: 5,
              child: const SizedBox(
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
