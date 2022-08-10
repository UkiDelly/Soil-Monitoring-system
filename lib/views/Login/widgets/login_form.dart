import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/porivder/garden.dart';
import 'package:thesis/porivder/token.dart';
import 'package:thesis/porivder/user_id.dart';
import 'package:thesis/views/Garden%20List/garden_list_page.dart';

import '../../../models/user.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  bool? successLogin;
  bool loading = false;
  //
  final _formKey = GlobalKey<FormState>();

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
                  //
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

                  //
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

          //
          const SizedBox(
            height: 30,
          ),

          //
          Consumer(
            builder: (context, ref, child) => SizedBox(
              width: 200,
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(fontSize: 30),
                        ),
                ),
                onPressed: () async {
                  // show it is loading
                  setState(() {
                    loading = true;
                  });

                  // create user instance
                  User user = User(
                      username: usernameController.text,
                      password: passwordController.text);

                  await user.login();

                  // if the text of the field is validate
                  if (_formKey.currentState!.validate()) {
                    if (user.token != false) {
                      // save the user id and token into the porivder
                      ref
                          .watch(userIDProvider.notifier)
                          .update((state) => user.userId);
                      ref
                          .watch(tokenProvider.notifier)
                          .update((state) => user.token);

                      ref.refresh(gardnenListProvider);

                      //* Go to the garden list
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const GardenListPage(),
                              type: PageTransitionType.fade));
                    } else if (user.token == false) {
                      setState(() {
                        successLogin = false;
                        loading = false;
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
