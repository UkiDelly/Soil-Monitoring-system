import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/ios_main_page.dart';
import 'package:thesis/Web/web_main.dart';

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

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final userNameText = usernameController.value.text;
    final passwordText = passwordController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (userNameText.isEmpty && passwordText.isEmpty) {
      return 'Can\'t be empty';
    }

    // return null if the text is valid
    return null;
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
                        ))),

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
                    onPressed: () {
                      if (!kIsWeb) {
                        Navigator.push(
                                context,
                                PageTransition(
                                    child: const MobileHome(),
                                    type: PageTransitionType.fade))
                            .then((value) {
                          setState(() {});
                        });
                      } else {
                        Navigator.push(
                                context,
                                PageTransition(
                                    child: const WebMain(),
                                    type: PageTransitionType.fade))
                            .then((value) {
                          setState(() {});
                        });
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
