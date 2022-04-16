import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/Main%20Page/mobile_main.dart';
import 'package:thesis/IOS/New%20Garden%20Page/plants.dart';
import 'package:thesis/main.dart';

import '../../Main/provider.dart';

class AddNewGarden extends ConsumerStatefulWidget {
  const AddNewGarden({Key? key}) : super(key: key);

  @override
  ConsumerState<AddNewGarden> createState() => _AddNewGardenState();
}

class _AddNewGardenState extends ConsumerState<AddNewGarden> {
  @override
  void initState() {
    super.initState();
  }

  //text controller
  var nameControl = TextEditingController(),
      noteControl = TextEditingController();

  createGarden() async {
    final _token = ref.watch(tokenProvider);
    var _gardenId;
    const _url = "https://soilanalysis.loca.lt/v1/garden/create";
    // const _url = "http://localhost:3000/v1/garden/create";
    var _response = await http.post(Uri.parse(_url),
        body: {"name": nameControl.text, "notes": noteControl.text},
        headers: {'Authorization': "Bearer $_token"});

    //? get the gardenId from the response
    if (_response.statusCode == 200) {
      var _item = jsonDecode(_response.body);
      _gardenId = _item['data']['insertedId'];
    }
    const _sensorUrl = 'https://soilanalysis.loca.lt/v1/sensor/create';
    // const _sensorUrl = 'http://localhost:3000/v1/sensor/create';
    _response = await http.post(Uri.parse(_sensorUrl),
        body: {"name": nameControl.text, "gardenId": _gardenId},
        headers: {'Authorization': "Bearer $_token"});
    if (_response.statusCode == 200) {
      var _item = jsonDecode(_response.body);

      setState(() {
        nameControl.text = "";
        noteControl.text = "";
      });

      //show Toast message
      _showToast(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return GestureDetector(
      //unfocuse eveything if tap the background
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // App bar
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          // Cancel button
          leading: TextButton(
              //disable splash
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context)),
          leadingWidth: 90,

          elevation: 0,
          actions: [
            // Add button
            TextButton(
                //disable splash
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  createGarden();

                  _showToast(context);

                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const MobileHome(),
                            type: PageTransitionType.leftToRight));
                  });
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                      color: Color(0xfffefefe),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),

        backgroundColor: isDarkMode ? const Color(0xff4f7c53) : mainColor,

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                const Center(
                  child: Text(
                    "Name",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),

                // Name text field
                Center(
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      style: TextStyle(
                          color: isDarkMode ? Colors.black : Colors.white),
                      controller: nameControl,
                      decoration: const InputDecoration(
                          hintText: "Enter a name",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Center(
                  child: Text(
                    "Notes",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),

                // notes
                Center(
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: noteControl,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Enter a note",
                      filled: true,
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                      ),
                      fillColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 3,
                ),

                // Choose plant
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("Plant",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                ),

                //

                //Plant Card
                const PlantCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    const SnackBar(
      content: Text('Successfully created a new Garden!'),
    ),
  );
}
