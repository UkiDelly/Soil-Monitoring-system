import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../Main/provider.dart';

class WebAddGarden extends ConsumerStatefulWidget {
  final Function() cancel;
  final Function() add;

  const WebAddGarden({Key? key, required this.cancel, required this.add})
      : super(key: key);

  @override
  ConsumerState<WebAddGarden> createState() => _WebAddGardenState();
}

class _WebAddGardenState extends ConsumerState<WebAddGarden> {
  //text controller
  final _nameControl = TextEditingController(),
      _noteControl = TextEditingController();

  _createGarden() async {
    final _token = ref.watch(tokenProvider);
    var _gardenId;

    // const _url = "https://soilanalysis.loca.lt/v1/garden/create";
    const _url = "http://localhost:3000/v1/garden/create";
    var _response = await http.post(Uri.parse(_url),
        body: {"name": _nameControl.text, "notes": _noteControl.text},
        headers: {'Authorization': "Bearer $_token"});

    //? get the gardenId from the response
    if (_response.statusCode == 200) {
      var _item = jsonDecode(_response.body);
      _gardenId = _item['data']['insertedId'];
      print(_gardenId);
    }

    // const _url = "https://soilanalysis.loca.lt/v1/sensor/create";
    const _sensorUrl = 'http://localhost:3000/v1/sensor/create';
    _response = await http.post(Uri.parse(_sensorUrl),
        body: {"name": _nameControl.text, "gardenId": _gardenId},
        headers: {'Authorization': "Bearer $_token"});
    if (_response.statusCode == 200) {
      var _item = jsonDecode(_response.body);

      setState(() {
        _nameControl.text = "";
        _noteControl.text = "";
      });

      //show Toast message
      _showToast(context);
    }

    //TODO: find way the rebuild the web main
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
              const SizedBox(
                height: 30,
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
                  controller: _nameControl,
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
                child: TextField(
                  controller: _noteControl,
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

              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  // Cancel
                  SizedBox(
                    child: ElevatedButton(
                        //disable splash
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 246, 245, 245)),
                        ),
                        onPressed: () {
                          widget.cancel();
                        },
                        child: const SizedBox(
                          width: 100,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        )),
                  ),

                  const Spacer(
                    flex: 1,
                  ),

                  // Add
                  ElevatedButton(
                      //disable splash
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 246, 245, 245)),
                      ),
                      onPressed: () {
                        _createGarden();
                        Future.delayed(const Duration(seconds: 1));
                        widget.add();
                      },
                      child: const SizedBox(
                        width: 100,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                                color: Color(0xff669D6B),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),

                  const Spacer(
                    flex: 2,
                  )
                ],
              )
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
