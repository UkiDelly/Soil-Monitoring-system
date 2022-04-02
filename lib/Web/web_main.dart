// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/Main/loading.dart';
import 'package:http/http.dart' as http;
import '../Main/login.dart';
import '../Main/provider.dart';
import 'Garden Page/web_garden_card.dart';
import 'Garden Page/web_garden_page.dart';

class WebMain extends StatelessWidget {
  String username;
  bool? createNewGarden = false;
  WebMain({Key? key, required this.username, this.createNewGarden})
      : super(key: key);

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
              ref.watch(webAddgardenActiveProvider.notifier).state = false;
            },
            child: const _WebMain());
      }),
    );
  }
}

class _WebMain extends ConsumerStatefulWidget {
  const _WebMain({Key? key}) : super(key: key);

  @override
  ConsumerState<_WebMain> createState() => __WebMainState();
}

class __WebMainState extends ConsumerState<_WebMain> {
  //? variable

  dynamic gardenList = {};
  bool isLoading = true;
  bool createNewGarden = false;

  //* Get garden list
  getGardenList() async {
    // const url = "http://soilanalysis.loca.lt/v1/garden/list";
    const url = "http://localhost:3000/v1/garden/list";
    var _response = await http.get(Uri.parse(url));
    var _item = jsonDecode(_response.body);

    List _temp = _item['data'];
    List _gardenList = [];
    final _userId = ref.watch(userIDProvider);

    for (var item in _temp) {
      if (item['createdBy'] == _userId) {
        _gardenList.add(item);
      }
    }

    //get the sensor list and save in the provider
    const sensorUrl = "http://localhost:3000/v1/sensor/list";
    _response = await http.get(Uri.parse(sensorUrl));
    _item = jsonDecode(_response.body);
    _temp = _item['data'];

    var _tempSensorIdList = [];
    for (var item in _temp) {
      _tempSensorIdList.add({
        "sensorId": item['_id'],
        "gardenId": item['gardenId'],
      });
    }

    ref.watch(sensorIdListProvider.notifier).state = _tempSensorIdList;

    setState(() {
      gardenList = _gardenList;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getGardenList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                      if (constraints.maxWidth < 850) {
                        return SizedBox(
                          child: Column(
                            children: [
                              _gardenTextAndAddButton(),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.1),
                                child: _list(width),
                              ))
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
                                child: createNewGarden
                                    ? _webAddNewGarden()
                                    : WebGarden(),
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
            // if the screen width is not enough
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
                setState(() {
                  createNewGarden = true;
                });
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
                setState(() {
                  createNewGarden = false;
                });

                //contain the garden Id ins the provider
                ref.watch(gardenIDProvider.notifier).state =
                    gardenList[index]['_id'];

                // if the with is not enough
                if (width < 850) {
                  Navigator.push(
                          context,
                          PageTransition(
                              child: const WebGardenMini(),
                              type: PageTransitionType.rightToLeft))
                      .then((value) {
                    ref.watch(selectionProvider.notifier).state =
                        SelectGarden(false, null);
                  });
                }
              },
              child: WebGardenCard(
                index: index + 1,
                name: gardenList[index]['name'],
                key: UniqueKey(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _webAddNewGarden() {
    //text controller
    var _nameControl = TextEditingController(),
        _noteControl = TextEditingController();

    _createGarden() async {
      final _token = ref.watch(tokenProvider);
      var _gardenId;

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

      const _sensorUrl = 'http://localhost:3000/v1/sensor/create';
      _response = await http.post(Uri.parse(_sensorUrl),
          body: {"name": _nameControl.text, "gardenId": _gardenId},
          headers: {'Authorization': "Bearer $_token"});
      if (_response.statusCode == 200) {
        var _item = jsonDecode(_response.body);
        print(_item);

        setState(() {
          _nameControl.text = "";
          _noteControl.text = "";
        });

        //show Toast message

      }

      //TODO: finish the create garden
      //TODO: Add a toast message after successfully created.
    }

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
                          setState(() {
                            createNewGarden = false;
                          });
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
                      onPressed: () {},
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
