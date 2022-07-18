import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/user.dart';
import '../Garden List/mobile_main.dart';
import '../Register/new_user.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),

          //Logo
          Center(
            child: Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/Logo/Logo.png',
                height: 200,
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // Login
          const _Login(),

          // Register
          _register(context),

          //
          const Spacer(flex: 2),
        ],
      )),
    );
  }

  Widget _register(_) {
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
                  _,
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

final _formKey = GlobalKey<FormState>();

class _Login extends StatefulWidget {
  const _Login({
    Key? key,
  }) : super(key: key);

  @override
  State<_Login> createState() => __LoginState();
}

class __LoginState extends State<_Login> {
  //
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  bool? successLogin;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  //User name
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: usernameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: "User name",
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff669D6B), width: 3)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff669D6B), width: 3)),
                            errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 3)),
                            errorText: successLogin == false
                                ? "No user exist!"
                                : null),
                        validator: (username) {
                          if (username == "") {
                            return "Please enter a username";
                          }
                          return null;
                        },
                      )),

                  const SizedBox(
                    height: 10,
                  ),

                  //Password
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: "Enter Password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff669D6B), width: 3)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff669D6B), width: 3)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3))),
                      validator: (password) {
                        if (password == "") {
                          return "Please enter a password";
                        }
                        return null;
                      },
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 30,
          ),
          Consumer(
            builder: (context, ref, child) => SizedBox(
              width: 200,
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                onPressed: () async {
                  User user = User(
                      username: usernameController.text,
                      password: passwordController.text);

                  await user.login(context: context);

                  // if the text of the field is validate
                  if (_formKey.currentState!.validate()) {
                    if (user.token != false) {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: MobileHome(
                                  token: user.token, userId: user.userId),
                              type: PageTransitionType.fade));
                    } else if (user.token == false) {
                      setState(() {
                        successLogin == false;
                      });
                    }
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
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
          Text(" Warning!"),
        ],
      ),
      content: const Text("The Server is offline"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
