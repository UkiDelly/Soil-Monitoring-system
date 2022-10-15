import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/Login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* unable to rotate
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(const ProviderScope(child: MyApp()));
}

const mainColor = Color(0xff669D6B);
const mainDarkColor = Color(0xff4c7750);

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soil Analysis System',
      theme: ThemeData(
        fontFamily: "ReadexPro",
        colorScheme: ColorScheme.fromSeed(
          primary: mainColor,
          seedColor: mainColor,
          surface: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: "ReadexPro",
        colorScheme: ColorScheme.fromSeed(
            primary: mainDarkColor,
            seedColor: mainDarkColor,
            surface: const Color(0xff424242),
            brightness: Brightness.dark),
      ),
      home: const LoginPage(),
    );
  }
}
