import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/Login/login.dart';

void main() async {
  //? disable rotate
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

const mainColor = Color(0xff669D6B);
const mainDarkColor = Color(0xff4c7750);

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

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
            // const TestPage()
            const LoginPage());
  }
}
