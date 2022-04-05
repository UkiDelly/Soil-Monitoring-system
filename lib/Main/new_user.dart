import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:thesis/Main/loading.dart';

import 'login.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController nameControl = TextEditingController();
  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  //* Create new user
  createNewUser(var name, var username, var password) async {
    setState(() {
      isLoading = true;
    });

    //* make the input data into map
    Map<String, dynamic> newUser = {
      "name": name,
      "username": username,
      "password": password
    };

    const url = "https://soilanalysis.loca.lt/v1/user/create";
    // const url = "http://localhost:3000/v1/user/create";

    //* http post request
    var response = await http.post(Uri.parse(url), body: newUser);

    //if successfully sign in,
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      //if user is already exist
    } else if (response.statusCode == 404) {
      setState(() {
        isLoading = false;
      });

      //if the server is offline
    } else {
      showAlertDialog(context);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff669D6B),
        title: const Text(
          "Register",
          style: TextStyle(fontSize: 30),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      body: SafeArea(
          child: Center(
        child: isLoading
            ? const LoadingPage()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //* Full name of the User
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: nameControl,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          prefixIcon: Icon(Icons.alternate_email_rounded),
                          labelText: "Name"),
                    ),
                  ),

                  //
                  const SizedBox(
                    height: 20,
                  ),

                  //* username of the user
                  SizedBox(
                    width: 300,
                    child: TextField(
                        controller: userNameControl,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            labelText: "User name")),
                  ),

                  //
                  const SizedBox(
                    height: 20,
                  ),

                  //* password of the user
                  SizedBox(
                      width: 300,
                      child: TextField(
                        obscureText: true,
                        controller: passwordControl,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password"),
                      )),

                  // sign up button
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff669D6B))),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 30),
                      ),
                      onPressed: () {
                        // create new user
                        createNewUser(nameControl.text, userNameControl.text,
                            passwordControl.text);

                        _showToast(context);

                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: const LoginPage(),
                                type: PageTransitionType.leftToRight));
                      },
                    ),
                  )
                ],
              ),
      )),
    );
  }
}

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    const SnackBar(
      content: Text('Successfully Sign Up!'),
    ),
  );
}
