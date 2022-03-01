import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/mobile_main.dart';

import 'package:thesis/IOS/new_user.dart';
import 'package:thesis/Web/web_main.dart';
import 'package:http/http.dart' as http;
import 'riverpod.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
      backgroundColor: Color(0xfffffff0),
      body: SafeArea(
        child: SizedBox(
          child: _Login(),
        ),
      ),
    );
  }
}

class _Login extends ConsumerStatefulWidget {
  const _Login({Key? key}) : super(key: key);

  @override
  __LoginState createState() => __LoginState();
}

class __LoginState extends ConsumerState<_Login> {
  //
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool successLogin = false;
  //

//*Login
  login() async {
    //? Loading data
    setState(() {
      isLoading = true;
    });

    const url = "http://localhost:3000/v1/user/login";
    final response = await http.post(Uri.parse(url), body: {
      'username': usernameController.text,
      'password': passwordController.text
    });

    var item = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        successLogin = true;
      });
//* Save the token for further use
      ref.watch(tokenProvider.notifier).setToken(item["data"]["authToken"]);
    } else if (response.statusCode == 401) {
//!  When authorization is fail
      ref.watch(tokenProvider.notifier).setToken(item["status"].toString());

      //? Done loading data
      setState(() {
        isLoading = false;
        usernameController.text = "";
        passwordController.text = "";
      });
    } else {
      showAlertDialog(context);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Color(0xff669D6B),
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedTextKit(animatedTexts: [
                  TyperAnimatedText("Loading...",
                      curve: Curves.linear,
                      textStyle: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold))
                ]),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
//* Logo
                SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset("assets/Logo.svg"),
                ),
                const SizedBox(
                  height: 15,
                ),
//? Login
                __login(),

                //
                const SizedBox(height: 100),
                const Text("Don't have an account?",
                    style: TextStyle(fontSize: 20, color: Colors.black)),
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
                    style: TextStyle(
                        decoration: TextDecoration.underline, fontSize: 30),
                  ),
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
                )
              ],
            ),
    );
  }

  //
  Widget __login() {
    return SizedBox(
      child: Column(children: [
//? User name
        SizedBox(
            width: 300,
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: usernameController,
              decoration: InputDecoration(
                focusColor: const Color(0xfffffff0),
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
        Consumer(
          builder: (_, ref, __) {
            return SizedBox(
              height: 55,
              width: 250,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff669D6B))),
                onPressed: () async {
//? Do the login process and wait until done
                  await login();

//! Check it the token is given
                  if (successLogin) {
//* If the platform is mobile
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child:
                                kIsWeb ? const WebMain() : const MobileHome(),
                            type: PageTransitionType.fade));
                  }
//* if the platform is web
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontFamily: "Readex Pro",
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        )
      ]),
    );
  }

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
            color: Colors.yellowAccent,
          )
        ],
      ),
      content: const Text("The Server is offline~"),
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
}
