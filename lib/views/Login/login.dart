import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/views/Login/widgets/login_form.dart';

import '../Register/new_user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
          const LoginForm(),

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
