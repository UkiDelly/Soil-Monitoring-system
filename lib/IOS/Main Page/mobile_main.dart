import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/Main/loading.dart';

import '../../Main/provider.dart';
import '../New Garden Page/new_garden_page.dart';
import 'garden_card.dart';
import 'package:http/http.dart' as http;

class MobileHome extends StatelessWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //? Set the system status color to black since the background is light
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarOpacity: 0,
          elevation: 0,
          actions: [
            TextButton(
              child: const Text(
                "Log out",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          bottom: false,
          child: SizedBox(
            child: Column(
              children: [
                aboveGardenList(context),

                const SizedBox(
                  height: 10,
                ),
                //* Garden List
                Consumer(
                  builder: (ctx, ref, child) {
                    //* get the token from the provider
                    final token = ref.watch(tokenProvider);
                    return GardenList(token: token);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget aboveGardenList(context) {
    return SizedBox(
      child: Column(
        children: [
          //* Logo
          Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/Logo/Logo.png',
                width: 60,
              )),
          const SizedBox(
            height: 10,
          ),

          //* My gardens
          Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "My Gardens",
                    style:
                        (TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  ),
                ),
                IconButton(
                    splashColor: Colors.white.withOpacity(0),
                    highlightColor: Colors.white.withOpacity(0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const AddNewGarden(),
                              type: PageTransitionType.rightToLeft));
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 40,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class GardenList extends ConsumerStatefulWidget {
  var token = "";
  GardenList({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  ConsumerState<GardenList> createState() => _GardenListState();
}

class _GardenListState extends ConsumerState<GardenList> {
  //
  List gardenList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getGardenList();
  }

  //? get the garden list
  getGardenList() async {
    setState(() {
      isLoading = true;
    });
    // get the garden list
    // const url = "https://soilanalysis.loca.lt/v1/garden/list";
    const url = "http://localhost:3000/v1/garden/list";

    var _response = await http.get(Uri.parse(url));
    var _item = jsonDecode(_response.body);

    List _temp = _item['data'];
    List _gardenList = [];

    //get the userId for the provider
    final _userId = ref.watch(userIDProvider);

    //find the garden of the user
    for (var item in _temp) {
      if (item['createdBy'] == _userId) {
        _gardenList.add(item);
      }
    }

    //save the garden list into the provider
    ref.watch(gardenIdListProvider.notifier).state = _gardenList;

    setState(() {
      gardenList = _gardenList;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //! if the app is getting the gardenList from the api show loading widget
    return isLoading
        ? const Center(child: LoadingPage())

        //? Show the garden List
        : Expanded(
            child: ListView.builder(
                itemCount: gardenList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return GardenCard(
                    index: index + 1,
                    gardenId: gardenList[index]['_id'],
                    gardenName: gardenList[index]['name'],
                    notes: gardenList[index]['notes'],
                  );
                }),
          );
  }
}
