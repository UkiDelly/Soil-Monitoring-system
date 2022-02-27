import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:thesis/IOS/ios_main_page.dart';
import 'package:thesis/Web/web_main.dart';
import 'package:http/http.dart' as http;
import 'provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool nameError = false;
  bool passwordError = false;
  String token = "";

  //Login
  login() async {
    const url = "http://localhost:3000/v1/user/login";
    final response = await http.post(Uri.parse(url), body: {
      'username': usernameController.text,
      'password': passwordController.text
    });
    var item = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        //* Save the token
        token = item["data"]["authToken"];
      });
    } else {
      setState(() {
        //*  When authorization is fail
        token = item["status"].toString();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                //* Login Text
                SizedBox(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset("assets/Logo.svg"),
                ),
                const SizedBox(
                  height: 15,
                ),

                //? User name
                SizedBox(
                    width: 300,
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
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
                            errorText: _errorText(token)))),

                const SizedBox(
                  height: 15,
                ),

                //? Login Button
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff669D6B))),
                    onPressed: () async {
                      //? Do the login process and wait until done
                      await login();

                      //! Check it the token is given
                      if (token.isNotEmpty && token != "400") {
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

                      //? Store the token for further use
                      Provider.of<Token>(context, listen: false)
                          .setToken(token);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//! Error message if the token is invalid
String? _errorText(String token) {
  if (token == "400") {
    return "Incorrect Username or Password";
  } else {
    return null;
  }
}
