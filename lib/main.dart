import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'login.dart';
import 'settings/preferences.dart';
import 'settings/provider.dart';
import 'views/mobile_main.dart';

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
  // This widget is the root of your application.
  bool? successLogin;
  autoLogin() async {
    if (LoginPreferences.getToken() != null) {
      final token = LoginPreferences.getToken();
      // const url = "https://soilanalysis.loca.lt/v1/user/list";
      const url = "http://localhost:3000/v1/user/list";
      var response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      // token is still valid
      if (response.statusCode == 200) {
        successLogin = true;
        //save the token
        ref.watch(tokenProvider.notifier).state = token!;
        //save the user Id
        ref.watch(userIDProvider.notifier).state =
            LoginPreferences.getUserId()!;

        //token is expired
      } else if (response.statusCode == 403) {
        //Go to login page
        successLogin = false;

        //server is offline
      } else {
        successLogin = false;
      }
      setState(() {
        successLogin;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    autoLogin();
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
            successLogin == true ? const MobileHome() : const Login());
  }
}
