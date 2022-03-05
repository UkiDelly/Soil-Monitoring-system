import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: Color(0xff669D6B),
        ),
        const SizedBox(
          height: 10,
        ),
        AnimatedTextKit(animatedTexts: [
          TyperAnimatedText("Loading...",
              curve: Curves.linear,
              textStyle:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
        ]),
      ],
    );
  }
}
