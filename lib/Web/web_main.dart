// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/Main/loading.dart';
import 'package:http/http.dart' as http;
import 'package:thesis/Web/New%20Garden%20Page/web_new_garden.dart';
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

  var gardenList;
  bool isLoading = true;
  bool createNewGarden = false;

  //* Get garden list
  getGardenList() async {
    const url = "http://soilanalysis.loca.lt/v1/garden/list";
    // const url = "http://localhost:3000/v1/garden/list";
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
    const sensorUrl = "https://soilanalysis.loca.lt/v1/sensor/list";
    // const sensorUrl = "http://localhost:3000/v1/sensor/list";
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

    return _gardenList;
  }

  @override
  void initState() {
    super.initState();
    getGardenList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: getGardenList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: LoadingPage(),
          );
        }

        return Column(
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
                                    MediaQuery.of(context).size.width * 0.1),
                            child: _list(width, snapshot),
                          ))
                        ],
                      ),
                    );
                  }

                  return SizedBox(
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: width * 0.3),
                          child: Column(
                            children: [
                              _gardenTextAndAddButton(),
                              Expanded(child: _list(width, snapshot.data))
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          width: 5,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: createNewGarden
                                ? WebAddGarden(
                                    cancel: () {
                                      setState(() {
                                        createNewGarden = false;
                                      });
                                    },
                                    add: () {
                                      setState(() {});
                                    },
                                  )
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
        );
      },
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

  Widget _list(var width, var gardenList) {
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
}
