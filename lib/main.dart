import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/login.dart';

import 'settings/preferences.dart';

void main() async {
  //? disable rotate
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await LoginPreferences.init();
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

        //* Theme settings of the app
        theme: ThemeData(
          backgroundColor: const Color.fromARGB(255, 246, 245, 245),
          fontFamily: "ReadexPro",
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff669D6B), brightness: Brightness.light),
        ),
        // brightness: Brightness.light),
        darkTheme: ThemeData(
          backgroundColor: const Color(0xff303030),
          fontFamily: "ReadexPro",
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff669D6B), brightness: Brightness.dark),
          // brightness: Brightness.dark
        ),
        debugShowCheckedModeBanner: false,
        title: "Soil Monitoring System",
        home:
            // const TestPage()
            const Login());
  }
}
