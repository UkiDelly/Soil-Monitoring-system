import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:thesis/provider.dart';

class WebAddNewGarden extends ConsumerStatefulWidget {
  const WebAddNewGarden({Key? key}) : super(key: key);

  @override
  ConsumerState<WebAddNewGarden> createState() => _AddNewGardenState();
}

class _AddNewGardenState extends ConsumerState<WebAddNewGarden> {
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

    const _url = "http://localhost:3000/v1/garden/create";
    var _response = await http.post(Uri.parse(_url),
        body: {"name": nameControl.text, "notes": noteControl.text},
        headers: {'Authorization': "Bearer $_token"});

    //? get the gardenId from the response
    if (_response.statusCode == 200) {
      var _item = jsonDecode(_response.body);
      _gardenId = _item['data']['insertedId'];
      print(_gardenId);
    }

    const _sensorUrl = 'http://localhost:3000/v1/sensor/create';
    _response = await http.post(Uri.parse(_sensorUrl),
        body: {"name": nameControl.text, "gardenId": _gardenId},
        headers: {'Authorization': "Bearer $_token"});
    if (_response.statusCode == 200) {
      var _item = jsonDecode(_response.body);
      print(_item);

      setState(() {
        nameControl.text = "";
        noteControl.text = "";
      });

      //show Toast message
      _showToast(context);
    }

    //TODO: finish the create garden
    //TODO: Add a toast message after successfully created.
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //unfocuse eveything if tap the background
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Card(
        color: const Color(0xff669D6B),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //buttons
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          //disable splash
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 246, 245, 245)),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {}),
                      ElevatedButton(
                          //disable splash
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 246, 245, 245)),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Add",
                            style: TextStyle(
                                color: Color(0xff669D6B),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ))
                    ]),
              ),

              // Name
              const Text(
                "Name",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              // Name text field
              SizedBox(
                width: 300,
                child: TextField(
                  controller: nameControl,
                  decoration: const InputDecoration(
                    hintText: "Enter a name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "Notes",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              // notes
              SizedBox(
                width: 350,
                height: 400,
                child: TextField(
                  controller: noteControl,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: "Enter a note",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
            ],
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
