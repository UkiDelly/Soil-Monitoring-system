import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/ios_main_page.dart';
import 'package:flutter/services.dart';

void main() {
  // disable rotate
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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
    //check the platform
    if (!kIsWeb) {
      return const Scaffold(
        body: SafeArea(bottom: false, child: Home()),
      );
    }

    //If Web
    return Container();

    // Safe Area
  }
}
