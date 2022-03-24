import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/Main/loading.dart';
import 'package:thesis/provider.dart';
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
            backgroundColor: const Color.fromARGB(255, 246, 245, 245),
            toolbarOpacity: 0,
            elevation: 0,
            toolbarHeight: 0),
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 246, 245, 245),
        body: SafeArea(
          bottom: false,
          child: SizedBox(
            child: Column(
              children: [
                const AboveGardenList(),

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
}

class AboveGardenList extends StatelessWidget {
  const AboveGardenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          //* Logo
          SizedBox(
            width: 60,
            height: 60,
            child: SvgPicture.asset("assets/Logo/Logo.svg"),
          ),
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
  int gardenCount = 0;
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
    // const url = "http://soilanalysis.loca.lt/v1/garden/list";
    const url = "http://localhost:3000/v1/garden/list";
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.token}'});
    var item = jsonDecode(response.body);

    List temp = item['data'];
    final userID = ref.watch(userIDProvider);

    for (int i = 0; i < temp.length; i++) {
      if (temp[i]['createdBy'] != userID) {
        temp.removeAt(i);
      }
    }

    setState(() {
      gardenList = temp;
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
            // width: MediaQuery.of(context).size.width * 0.95,
            // height: MediaQuery.of(context).size.height * 0.75,
            child: ListView.builder(
                itemCount: gardenList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return GardenCard(
                    index: index + 1,
                    gardenID: gardenList[index]['_id'],
                    gardenName: gardenList[index]['name'],
                  );
                }),
          );
  }
}
