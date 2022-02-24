import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thesis/IOS/ios_main_page.dart';
import 'package:flutter/services.dart';
import 'package:thesis/Web/web_main.dart';

void main() {
  //? disable rotate
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
        title: "Soil Monitoring System",
        home: kIsWeb == false ? MobileHome() : WebMain());
  }
}
