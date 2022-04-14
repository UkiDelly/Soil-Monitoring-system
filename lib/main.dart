import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Main/login.dart';

void main() {
  //? disable rotate
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          backgroundColor: const Color.fromARGB(255, 246, 245, 245),
          fontFamily: "ReadexPro",
          primarySwatch: Colors.green,
          brightness: Brightness.light),
      darkTheme: ThemeData(
          backgroundColor: const Color(0xff303030),
          fontFamily: "ReadexPro",
          primarySwatch: Colors.green,
          brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      title: "Soil Monitoring System",
      home:
          //const AddNewGarden()
          const LoginPage(),
    );
  }
}
