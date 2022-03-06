import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController nameControl = TextEditingController();
  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

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
          icon: SvgPicture.asset("icons/back.svg", height: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: nameControl,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    prefixIcon: Icon(Icons.alternate_email_rounded),
                    labelText: "Name"),
              ),
            ),

            //
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                  controller: userNameControl,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      labelText: "User name")),
            ),

            //
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: passwordControl,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password"),
                )),

            //
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 270,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff669D6B))),
                onPressed: () {},
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
