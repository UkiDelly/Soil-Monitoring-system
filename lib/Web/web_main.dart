import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/Web/Web%20Garden%20Page/web_garden_card.dart';
import 'package:thesis/Web/Web%20Garden%20Page/web_garden_page.dart';
import 'package:thesis/loading.dart';
import 'package:thesis/provider.dart';
import 'package:http/http.dart' as http;

class WebMain extends ConsumerStatefulWidget {
  String username, token;
  WebMain({Key? key, required this.username, required this.token})
      : super(key: key);

  @override
  ConsumerState<WebMain> createState() => _WebMainState();
}

class _WebMainState extends ConsumerState<WebMain> {
  // variable
  int gardenListLength = 0;
  bool isTapped = false;
  bool isLoading = false;
  var gardenList;
  int selectedGarden = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGardenList();
  }

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
      body: isLoading
          ? const Center(child: LoadingPage())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //
                const SizedBox(height: 10),

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

                      //* Garden Page
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
                            : 0,
                        child: WebGarden(
                          isTapped: isTapped,
                          gardenID: gardenList[selectedGarden]["_id"],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  getGardenList() async {
    setState(() {
      isLoading = true;
    });
    const url = "https://soilanalysis.loca.lt/v1/garden/list";
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.token}'});
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);

      setState(() {
        gardenListLength = item['data'].length;
        gardenList = item['data'];
        isLoading = false;
      });
    }
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
                focusColor: Colors.white.withOpacity(0),
                highlightColor: Colors.white.withOpacity(0),
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
                itemCount: gardenListLength,
                itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        isTapped = !isTapped;
                        selectedGarden = index;
                      });

                      print(gardenList);

                      // If the with is not enough
                      if (MediaQuery.of(context).size.width < 550) {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: WebGardenMini(
                                  isTapped: isTapped,
                                  gardenID: gardenList[index]['_id'],
                                ),
                                type: PageTransitionType.rightToLeft));
                      }
                    },
                    child: WebGardenCard(
                      index: index + 1,
                      name: gardenList[index]["name"],
                    ))),
          ),
        )
      ],
    );
  }
}
