import 'package:flutter/material.dart';
import 'package:thesis/Home%20page%20widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      color: Color(0xffFEFEFE),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// Main Home Page
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Safe Area
    return Scaffold(
      body: SafeArea(bottom: false, child: Home()),
    );
  }
}
