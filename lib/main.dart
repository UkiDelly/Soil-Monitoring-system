import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:thesis/IOS/Main%20Page/mobile_main.dart';
import 'package:thesis/Main/preferences.dart';
import 'Main/login.dart';
import 'Main/provider.dart';

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

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  bool? login;

  autoLogin() async {
    const url = "https://soilanalysis.loca.lt/v1/user/login";
    String userId = '', password = '';
    if (LoginPreferences.getId() != null &&
        LoginPreferences.getPassword() != null) {
      userId = LoginPreferences.getId()!;
      password = LoginPreferences.getPassword()!;
    }
    // const url = "http://localhost:3000/v1/user/login";
    final response = await http.post(Uri.parse(url),
        body: {'username': userId, 'password': password},
        headers: {"Access-Control_Allow_Origin": "*"});

    var _item = {};

    if (response.statusCode == 200) {
      _item = jsonDecode(response.body);
      //* Save the token
      ref.watch(tokenProvider.notifier).state = _item['data']['authToken'];

      var tokenDecode = Jwt.parseJwt(_item['data']['authToken']);

      //* Save the userID
      ref.watch(userIDProvider.notifier).state = tokenDecode['_id'];
      login = true;
    }
    ref.watch(tokenProvider.notifier).state = "401";
    login = false;

    setState(() {
      login;
    });
  }

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    print(login);
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
          login == true ? const MobileHome() : const LoginPage(),
    );
  }
}
