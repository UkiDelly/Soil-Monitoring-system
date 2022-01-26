import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddNewGarden extends StatelessWidget {
  const AddNewGarden({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        backgroundColor: const Color(0xff669D6B),

        // Cancel button
        leading: TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        leadingWidth: 90,
        elevation: 0,
        actions: [
          // Add button
          TextButton(
              onPressed: () {},
              child: const Text(
                "Add",
                style: TextStyle(color: Color(0xfffefefe), fontSize: 20),
              ))
        ],
      ),

      backgroundColor: Color(0xff669D6B),
    );
  }
}
