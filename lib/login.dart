import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:thesis/IOS/Main%20Page/mobile_main.dart';
import 'package:thesis/Web/renewal_web_main.dart';

import 'new_user.dart';

import 'loading.dart';
import 'provider.dart';

//! Error message if the token is invalid
String? _errorText(String token) {
  if (token == "400") {
    return "Incorrect Username or Password";
  } else {
    return null;
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 246, 245, 245),
      body: _Login(),
    );
  }
}

class _Login extends ConsumerStatefulWidget {
  const _Login({Key? key}) : super(key: key);

  @override
  ConsumerState<_Login> createState() => __LoginState();
}

class __LoginState extends ConsumerState<_Login> {
  bool isLoading = false, succesLogin = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = "";

  //*Login func
  login() async {
    //? Loading data
    setState(() {
      isLoading = true;
    });

    // const url = "https://soilanalysis.loca.lt/v1/user/login";
    const url = "http://localhost:3000/v1/user/login";
    final response = await http.post(Uri.parse(url), body: {
      'username': usernameController.text,
      'password': passwordController.text
    });

    var item = {};
    //* Login is success
    if (response.statusCode == 200) {
      item = jsonDecode(response.body);
      //* Save the token
      await ref
          .watch(tokenProvider.notifier)
          .setToken(item['data']['authToken']);
      //* Save the userID
      ref.watch(userIdProvider.notifier).state = "";
      setState(() {
        username = usernameController.text;
        succesLogin = true;
        isLoading = false;
      });
    } else if (response.statusCode == 401) {
      item = jsonDecode(response.body);
//!  When authorization is fail

      ref.watch(tokenProvider.notifier).state = item['data']['authToken'];
      //? Done loading data
      setState(() {
        isLoading = false;
        usernameController.text = "";
        passwordController.text = "";
      });
    } else {
//? Done loading data
      showAlertDialog(context);
      setState(() {
        isLoading = false;
        usernameController.text = "";
        passwordController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: isLoading
            ? const LoadingPage()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //* Logo
                  _logo(),

                  //
                  const SizedBox(
                    height: 15,
                  ),

                  //* Input
                  _loginInput(),

                  const SizedBox(
                    height: 100,
                  ),

                  _register()
                ],
              ));
  }

  Widget _logo() {
    return SizedBox(
        child: SvgPicture.asset(
      "assets/Logo/Logo.svg",
      height: 120,
    ));
  }

  //? Login
  Widget _loginInput() {
    return SizedBox(
      child: Column(
        children: [
          //? User name
          SizedBox(
              width: 300,
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: usernameController,
                decoration: InputDecoration(
                  focusColor: const Color.fromARGB(255, 246, 245, 245),
                  hintText: "username",
                  prefixIcon: const Icon(Icons.account_circle_outlined),
                  filled: true,
                  fillColor: Colors.blue.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              )),

          //
          const SizedBox(
            height: 15,
          ),

          //? Password
          SizedBox(
              width: 300,
              child: TextField(
                  textInputAction: TextInputAction.done,
                  //* Hide the password
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: "password",
                      prefixIcon: const Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      //! if token is not valid, show error
                      errorText: _errorText(ref.watch(tokenProvider))))),

          const SizedBox(
            height: 15,
          ),

          //? Login Button
          SizedBox(
            height: 55,
            width: 150,
            child: ElevatedButton(
              onPressed: () async {
                await login();
                //* Check if its success to login
                if (succesLogin) {
                  Navigator.pushReplacement(
                      (context),
                      PageTransition(
                          child: kIsWeb
                              //* if the platform is web, open the web page
                              ? WebMain(username: username)
                              //* else open the mobile page
                              : const MobileHome(),
                          type: PageTransitionType.fade));
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff669d6b))),
            ),
          )
        ],
      ),
    );
  }

  Widget _register() {
    return SizedBox(
      child: Column(
        children: [
          //
          const Text("You don't have an account?",
              style: TextStyle(fontSize: 25)),
          TextButton(
            onPressed: () {
//? Register Page
              Navigator.push(
                  context,
                  PageTransition(
                      child: const SignInPage(),
                      type: PageTransitionType.rightToLeft));
            },
            child: const Text(
              "Sign In!",
              style:
                  TextStyle(decoration: TextDecoration.underline, fontSize: 25),
            ),
            style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
          ),
        ],
      ),
    );
  }
}

//! Show the alert if the server is offline
showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text(
      "OK",
      style: TextStyle(color: Color(0xff669D6B)),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      children: const [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.redAccent,
        ),
        Text(" Warning!", style: TextStyle(color: Colors.black)),
      ],
    ),
    content: const Text("The Server is offline",
        style: TextStyle(color: Colors.black)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
