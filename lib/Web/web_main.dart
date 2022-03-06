import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/login.dart';

class WebMain extends StatelessWidget {
  String username = "";
  WebMain({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //
          const SizedBox(height: 10),

          customAppBar(context),
        ],
      ),
    );
  }

  Widget customAppBar(_) {
    return SizedBox(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Spacer(),
        SizedBox(
          child: Row(
            children: [
              SvgPicture.asset('Logo/Logo.svg'),
              const SizedBox(
                width: 5,
              ),
              Text(
                "$username's Garden",
                style: const TextStyle(fontSize: 40),
              )
            ],
          ),
        ),
        const Spacer(),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  (_),
                  PageTransition(
                      child: const LoginPage(),
                      type: PageTransitionType.leftToRight));
            },
            child: const Text(
              "Logout",
              style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  fontSize: 20),
            ))
      ]),
    );
  }
}
