import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/Web/Web%20Garden%20Page/web_garden_card.dart';
import 'package:thesis/Web/Web%20Garden%20Page/web_garden_page.dart';
import 'package:thesis/login.dart';

class WebMain extends StatefulWidget {
  String username = "";
  WebMain({Key? key, required this.username}) : super(key: key);

  @override
  State<WebMain> createState() => _WebMainState();
}

class _WebMainState extends State<WebMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //* User's Garden
        title: Text("${widget.username}'s Garden"),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 40),
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        actions: [
          //* Logout button
          TextButton(
              style: ButtonStyle(
                  // remove hovor color
                  overlayColor:
                      MaterialStateProperty.all(Colors.white.withOpacity(0))),
              onPressed: () {},
              child: const Text("Logout",
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline)))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //
          const SizedBox(height: 10),

          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height - 70,
          //   color: Colors.red,
          // )

          //* Garden List
          SizedBox(
            height: MediaQuery.of(context).size.height - 70,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width > 550
                      ? MediaQuery.of(context).size.width * 0.49
                      : MediaQuery.of(context).size.width,
                  child: gardenListPart(),
                ),
                SizedBox(
                  child: MediaQuery.of(context).size.width > 550
                      ? const VerticalDivider(
                          width: 10,
                        )
                      : null,
                ),

                //* Detail Page
                SizedBox(
                    width: MediaQuery.of(context).size.width > 550
                        ? MediaQuery.of(context).size.width * 0.49
                        : 0)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget gardenListPart() {
    return Column(
      children: [
        //* Garden List Text and add button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Garden List",
              style: TextStyle(fontSize: 25),
            ),
            IconButton(
                hoverColor: Colors.white.withOpacity(0),
                splashColor: Colors.white.withOpacity(0),
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ))
          ],
        ),

        //* List
        Flexible(
          child: SizedBox(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10),
                itemCount: 10,
                itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      print(index);
                    },
                    child: const WebGardenCard())),
          ),
        )
      ],
    );
  }
}
