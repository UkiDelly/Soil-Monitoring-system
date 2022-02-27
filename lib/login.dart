import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/ios_main_page.dart';
import 'package:thesis/IOS/new_user.dart';
import 'package:thesis/Web/web_main.dart';
import 'package:http/http.dart' as http;
import 'riverpod.dart';

final tokenProvider =
    StateNotifierProvider<TokenNotifier, String>((ref) => TokenNotifier("0"));

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
    return Scaffold(
      backgroundColor: const Color(0xfffffff0),
      body: SafeArea(
        child: SizedBox(
          child: Center(
            child: Column(
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
                const _LoginWidget(),

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
          ),
        ),
      ),
    );
  }
}

class _LoginWidget extends ConsumerStatefulWidget {
  const _LoginWidget({Key? key}) : super(key: key);

  @override
  __LoginWidgetState createState() => __LoginWidgetState();
}

class __LoginWidgetState extends ConsumerState<_LoginWidget> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool nameError = false;
  bool passwordError = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
//? User name
        SizedBox(
            width: 300,
            child: TextField(
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
            final token = ref.watch(tokenProvider.notifier);
            return SizedBox(
              height: 55,
              width: 250,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff669D6B))),
                onPressed: () async {
//? Do the login process and wait until done
                  await login(usernameController, passwordController, token);

//! Check it the token is given
                  if (ref.watch(tokenProvider) != "0" &&
                      ref.watch(tokenProvider) != "400") {
//* If the platform is mobile
                    if (!kIsWeb) {
                      Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const MobileHome(),
                                  type: PageTransitionType.fade))
                          .then((value) {
                        setState(() {});
                      });
                    }
//* if the platform is web
                    else {
                      Navigator.push(
                              context,
                              PageTransition(
                                  child: const WebMain(),
                                  type: PageTransitionType.fade))
                          .then((value) {
                        setState(() {});
                      });
                    }
                  }
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
}

//Login
login(TextEditingController usernameController,
    TextEditingController passwordController, var tokenProvider) async {
  const url = "http://localhost:3000/v1/user/login";
  final response = await http.post(Uri.parse(url), body: {
    'username': usernameController.text,
    'password': passwordController.text
  });
  var item = jsonDecode(response.body);
  if (response.statusCode == 200) {
//* Save the token for further use
    tokenProvider.setToken(item["data"]["authToken"]);
  } else {
//!  When authorization is fail
    tokenProvider.setToken(item["status"].toString());
  }
}
