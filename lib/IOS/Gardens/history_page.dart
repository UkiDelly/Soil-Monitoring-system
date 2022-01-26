import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          //color: Colors.grey,
          ),
    );
  }
}
