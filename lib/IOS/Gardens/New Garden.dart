import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewGardenCard extends StatelessWidget {
  const NewGardenCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // make a new garden
    return Scaffold(
      backgroundColor: const Color(0xff669D6B),
      appBar: AppBar(
        backgroundColor: const Color(0xff669D6B),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/back.svg',
            width: 15,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Soil Status History",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          //color: Colors.grey,
          ),
    );
  }
}
