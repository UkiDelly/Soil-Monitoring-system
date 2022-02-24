import 'package:flutter/material.dart';

class WebGardenPage extends StatefulWidget {
  bool isPressed;
  int indexTapped;
  WebGardenPage({Key? key, required this.isPressed, required this.indexTapped})
      : super(key: key);

  @override
  _WebGardenPageState createState() => _WebGardenPageState();
}

class _WebGardenPageState extends State<WebGardenPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
      children: [
        //* Left Side
        SizedBox(
            width: (MediaQuery.of(context).size.width / 2) - 10,
            child: Column()),
        //* Right Side
        SizedBox(
            width: (MediaQuery.of(context).size.width / 2) - 10,
            child: Column())
      ],
    ));
  }
}
