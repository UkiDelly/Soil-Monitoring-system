import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/loading.dart';

import '../models/garden.dart';
import 'add new garden/new_garden_page.dart';
import 'garden_card.dart';

class MobileHome extends StatelessWidget {
  const MobileHome({
    Key? key,
  }) : super(key: key);

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
        body: const SafeArea(
          bottom: false,
          child: SizedBox(child: GardenList()),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GardenList extends StatefulWidget {
  const GardenList({
    Key? key,
  }) : super(key: key);

  @override
  State<GardenList> createState() => _GardenListState();
}

class _GardenListState extends State<GardenList> {
  //
  Garden garden = Garden();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //! if the app is getting the gardenList from the api show loading widget
    return FutureBuilder(
      //get the garden list
      future: garden.getGardenList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // if succesfully get data
        if (snapshot.hasData) {
          List gardenList = snapshot.data as List;
          return Column(
            children: [
              SizedBox(
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
                              style: (TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          IconButton(
                              splashColor: Colors.white.withOpacity(0),
                              highlightColor: Colors.white.withOpacity(0),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: AddNewGarden(
                                          callback: didChangeDependencies,
                                        ),
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
              ),

              // garden display
              Expanded(
                child: ListView.builder(
                    itemCount: gardenList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return GardenCard(
                        index: index + 1,
                        gardenId: gardenList[index]['_id'],
                        gardenName: gardenList[index]['name'],
                        notes: gardenList[index]['notes'],
                        plant: gardenList[index]['plant'],
                      );
                    }),
              ),
            ],
          );
        }

        // else, display loading
        return const LoadingPage();
      },
    );
  }
}
