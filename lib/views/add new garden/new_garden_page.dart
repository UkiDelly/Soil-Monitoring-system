import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:thesis/main.dart';
import 'package:thesis/views/add%20new%20garden/plants.dart';

import '../../settings/provider.dart';

class AddNewGarden extends ConsumerStatefulWidget {
  Function() callback;
  AddNewGarden({Key? key, required this.callback}) : super(key: key);

  @override
  ConsumerState<AddNewGarden> createState() => _AddNewGardenState();
}

class _AddNewGardenState extends ConsumerState<AddNewGarden> {
  //text controller
  var nameControl = TextEditingController(),
      noteControl = TextEditingController();
  String selectedPlants = '';
  late bool isDarkMode;

  createGarden() async {
    final _token = ref.watch(tokenProvider);
    var _gardenId;
    // const _url = "https://soilanalysis.loca.lt/v1/garden/create";
    const _url = "http://localhost:3000/v1/garden/create";
    var _response = await http.post(Uri.parse(_url), body: {
      "name": nameControl.text,
      "notes": noteControl.text,
      "plant": selectedPlants
    }, headers: {
      'Authorization': "Bearer $_token"
    });

    //? get the gardenId from the response
    if (_response.statusCode == 200) {
      var _item = jsonDecode(_response.body);
      _gardenId = _item['data']['insertedId'];
      // const _sensorUrl = 'https://soilanalysis.loca.lt/v1/sensor/create';
      const _sensorUrl = 'http://localhost:3000/v1/sensor/create';
      _response = await http.post(Uri.parse(_sensorUrl), body: {
        "name": nameControl.text,
        "gardenId": _gardenId,
        'plant': selectedPlants
      }, headers: {
        'Authorization': "Bearer $_token"
      });
      if (_response.statusCode == 200) {
        _item = jsonDecode(_response.body);

        //get the sensor id from the response and create a empty sensorData
        var _sensorId = _item['data']['id'];
        Map<String, num> initialData = {
          "nitrogen": 0,
          "phosphorous": 0,
          "potassium": 0,
          "pH": 0,
          "temperature": 0,
          "moisture": 0,
          "humidity": 0
        };

        final _sensorDataUrl =
            //'https://soilanalysis.loca.lt/v1/sensor/addSensorData/$_sensorId';
            'http://localhost:3000/v1/sensor/addSensorData/$_sensorId';
        _response = await http.put(Uri.parse(_sensorDataUrl),
            headers: {
              'Authorization': "Bearer $_token",
              'Content-Type': 'application/json'
            },
            body: json.encode(initialData));

        print(_response.statusCode);
      }
    }
  }

  getPlantName(plantName) {
    setState(() {
      selectedPlants = plantName;
    });
  }

  @override
  void initState() {
    super.initState();
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
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
                  if (_formKey.currentState!.validate()) {
                    if (selectedPlants == '') {
                      _showToast(context, "Please select a plant.");
                      return;
                    }
                    createGarden();
                    _showToast(context, "Successfully created a new Garden!");
                    //set state the main page
                    widget.callback;
                    Future.delayed(const Duration(seconds: 500), () {
                      Navigator.of(context).pop();
                    });
                  }
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
                const SizedBox(
                  height: 10,
                ),

                inputs(),

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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: PlantCard(
                    callback: ((String plantName) => getPlantName(plantName)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  Widget inputs() {
    return Form(
        key: _formKey,
        child: Column(
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
                child: TextFormField(
                  style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.white),
                  controller: nameControl,
                  decoration: const InputDecoration(
                    hintText: "Enter a name",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Colors.red, width: 3),
                    ),
                  ),
                  validator: (name) {
                    if (name == "") {
                      return "Please enter a name";
                    }
                    return null;
                  },
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
              child: TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: noteControl,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Enter a note",
                  hintStyle: const TextStyle(color: Colors.grey),
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
          ],
        ));
  }
}

void _showToast(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
    ),
  );
}
