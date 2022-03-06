import 'package:flutter/material.dart';

class WebPlantCard extends StatefulWidget {
  const WebPlantCard({Key? key}) : super(key: key);

  @override
  _WebPlantCardState createState() => _WebPlantCardState();
}

class _WebPlantCardState extends State<WebPlantCard> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),

      // Card
      child: _WebPlantCard(),
    );
  }
}

class _WebPlantCard extends StatefulWidget {
  const _WebPlantCard({Key? key}) : super(key: key);

  @override
  __WebPlantCardState createState() => __WebPlantCardState();
}

class __WebPlantCardState extends State<_WebPlantCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        width: 200,
        color: const Color.fromARGB(255, 246, 245, 245),
      ),
    );
  }
}
