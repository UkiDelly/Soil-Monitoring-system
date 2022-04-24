import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thesis/main.dart';

import '../../models/user.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // check dark mode is on
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? mainDarkColor : mainColor,
        title: const Text("Register"),
        titleTextStyle:
            const TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
      ),
      body: const Center(child: RegisterInput()),
    );
  }
}

final _formKey = GlobalKey<FormState>();

class RegisterInput extends StatefulWidget {
  const RegisterInput({Key? key}) : super(key: key);

  @override
  State<RegisterInput> createState() => _RegisterInputState();
}

class _RegisterInputState extends State<RegisterInput> {
  TextEditingController nameController = TextEditingController(),
      usernameController = TextEditingController(),
      passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Enter your full name",
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor))),

                //validator
                validator: (name) {
                  if (name == "") {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),

              //username
              TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email),
                      hintText: "Enter user name",
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: mainColor))), //validator
                  validator: (username) {
                    if (username == "") {
                      return "Please enter a user name";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 10,
              ),

              //password
              TextFormField(
                  controller: passwordController,
                  obscureText: showPassword ? false : true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Enter your full name",
                      filled: true,
                      suffixIcon: showPassword
                          ? IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => setState(() {
                                    showPassword = !showPassword;
                                  }),
                              icon: const Icon(Icons.visibility_off))
                          : IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => setState(() {
                                    showPassword = !showPassword;
                                  }),
                              icon: const Icon(Icons.visibility)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: mainColor))),
                  validator: (password) {
                    if (password == "") {
                      return "Please enter a password";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 30,
              ),

              //Register button
              ElevatedButton(
                  onPressed: () async {
                    User user = User(
                        name: nameController.text,
                        username: usernameController.text,
                        password: passwordController.text);
                    bool register = await user.register();
                    if (_formKey.currentState!.validate()) {
                      if (register) {
                        await Fluttertoast.showToast(
                            msg: "Successfully Register!",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: mainColor,
                            fontSize: 20.0);
                      } else {
                        print(register);
                      }
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 30),
                    ),
                  ))
            ],
          ),
        ));
  }
}
