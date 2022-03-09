import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/IOS/Main%20Page/mobile_main.dart';
import 'Web/web_main.dart';
import 'login.dart';

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
        theme: ThemeData(fontFamily: "Readex Pro"),
        debugShowCheckedModeBanner: false,
        title: "Soil Monitoring System",
        home:
            WebMain(
              username: "test user",
            )
            //LoginPage(),
            //const MobileHome()
            );
  }
}
