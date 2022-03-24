// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/Main/loading.dart';
import 'package:thesis/login.dart';
import 'package:thesis/provider.dart';
import 'package:http/http.dart' as http;

import 'Garden Page/web_garden_card.dart';
import 'Garden Page/web_garden_page.dart';

class WebMain extends StatelessWidget {
  String username;
  WebMain({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        //* User's Garden
        title: Text("$username's Garden"),
        titleTextStyle: const TextStyle(
          fontSize: 40,
        ),
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,

        actions: [
          //* Logout button
          TextButton(
              style: ButtonStyle(

                  //remove hovor color
                  overlayColor:
                      MaterialStateProperty.all(Colors.white.withOpacity(0))),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const LoginPage(),
                        type: PageTransitionType.fade));
              },
              child: const Text(
                "Log out",
                style: TextStyle(decoration: TextDecoration.underline),
              ))
        ],
      ),

      //
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      body: Consumer(builder: (context, ref, child) {
        //? Cancel the selection
        return GestureDetector(
            onTap: () {
              ref.watch(selectionProvider.notifier).state =
                  SelectGarden(false, null);
            },
            child: const _WebMain());
      }),
    );
  }
}

class _WebMain extends StatefulWidget {
  const _WebMain({Key? key}) : super(key: key);

  @override
  State<_WebMain> createState() => __WebMainState();
}

class __WebMainState extends State<_WebMain> {
  //? variable

  dynamic gardenList = {};
  bool isLoading = true;
  bool isTapped = false;
  int selectedGarden = 0;

  //* Get garden list
  getGardenList() async {
    // final url = "https://soilanalysis.loca.lt/v1/garden/list";
    const url = "http://localhost:3000/v1/garden/list";
    var response = await http.get(Uri.parse(url));
    var item = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        gardenList = item['data'];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getGardenList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      child: isLoading
          ? const Center(child: LoadingPage())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //
                const SizedBox(
                  height: 50,
                ),

                //* Garden list
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      //? if the witdh is small
                      if (constraints.maxWidth < 550) {
                        return SizedBox(
                          child: Column(
                            children: [
                              _gardenTextAndAddButton(),
                              Expanded(child: _list(width))
                            ],
                          ),
                        );
                      }

                      return SizedBox(
                        child: Row(
                          children: [
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: width * 0.3),
                              child: Column(
                                children: [
                                  _gardenTextAndAddButton(),
                                  Expanded(child: _list(width))
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                child: WebGarden(),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }

  Widget _gardenTextAndAddButton() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Spacer(
            flex: 1,
          ),
          const Text(
            "Garden list",
            style: TextStyle(fontSize: 40),
          ),
          const Spacer(
            flex: 3,
          ),
          IconButton(
              //remove splash and hovor color
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                //* Lead to the add garden

                //
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              )),
          const Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }

  Widget _list(var width) {
    return SizedBox(
      child: Flexible(
          child: Consumer(
        builder: (context, ref, child) => SizedBox(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10),
            itemCount: gardenList.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                //

                //tell it is selected
                ref.watch(selectionProvider.notifier).state =
                    SelectGarden(true, index);

                //contain the garden Id ins the provider
                ref.watch(gardenIDProvider.notifier).state =
                    gardenList[index]['_id'];

                // if the with is not enough
                if (width < 550) {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: WebGardenMini(
                            isTapped: isTapped,
                          ),
                          type: PageTransitionType.rightToLeft));
                }
              },
              child: WebGardenCard(
                  index: index + 1, name: gardenList[index]['name']),
            ),
          ),
        ),
      )),
    );
  }
}
