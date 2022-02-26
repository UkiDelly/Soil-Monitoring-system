import 'package:flutter/material.dart';

class StatusDisplay extends StatelessWidget {
  const StatusDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.check,
      color: Color(0xff669D6B),
      size: 75,
    );
  }
}
