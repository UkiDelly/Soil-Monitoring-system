import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:ndialog/ndialog.dart';
import 'package:page_transition/page_transition.dart';

import 'loading.dart';
import 'settings/preferences.dart';
import 'settings/provider.dart';
import 'views/add new user/new_user.dart';
import 'views/mobile_main.dart';

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
          Consumer(
            builder: (context, ref, child) {
              var token = ref.watch(tokenProvider.notifier);
              var userId = ref.watch(userIDProvider.notifier);
              return _Login(
                token: token,
                userId: userId,
              );
            },
          ),

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
  var token, userId;
  _Login({Key? key, required this.token, required this.userId})
      : super(key: key);

  @override
  State<_Login> createState() => __LoginState();
}

class __LoginState extends State<_Login> {
  //
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  bool? successLogin;
  //Dialon
  late CustomProgressDialog loadingDialog;
  //

  //* Login
  login(_) async {
    //show dialog
    loadingDialog = CustomProgressDialog(
      context,
      blur: 10,
      dismissable: false,
      loadingWidget: const Center(child: LoadingPage()),
    );

    loadingDialog.show();
    // const url = "https://soilanalysis.loca.lt/v1/user/login";
    const url = "http://localhost:3000/v1/user/login";
    final response = await http.post(Uri.parse(url), body: {
      'username': usernameController.text,
      'password': passwordController.text
    });

    var _item = {};

    // Login success
    if (response.statusCode == 200) {
      successLogin = true;
      _item = jsonDecode(response.body);

      //Save the token
      widget.token.state = _item['data']['authToken'];
      LoginPreferences.saveToken(_item['data']['authToken']);

      var tokenDecode = Jwt.parseJwt(_item['data']['authToken']);

      //Save the user id
      widget.userId.state = tokenDecode['_id'];
      LoginPreferences.saveUserId(tokenDecode['_id']);

      // No user exist
    } else if (response.statusCode == 401) {
      successLogin = false;
      loadingDialog.dismiss();
      // Server is offline
    } else {
      successLogin = false;
      loadingDialog.dismiss();
      showAlertDialog(context);
    }

    setState(() {
      successLogin;
      usernameController.text = "";
      passwordController.text = "";
    });
  }

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
          SizedBox(
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
                // if the text of the field is validate
                if (_formKey.currentState!.validate()) {
                  await login(context);

                  if (successLogin == true) {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const MobileHome(),
                            type: PageTransitionType.fade));
                  }
                }
              },
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
