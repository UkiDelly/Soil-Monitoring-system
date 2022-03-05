import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thesis/provider.dart';
import 'garden_card.dart';
import 'package:http/http.dart' as http;

class MobileHome extends StatelessWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //? Set the system status color to black since the background is light
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfffffff0),
          toolbarOpacity: 0,
          elevation: 0,
          toolbarHeight: 0),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xfffffff0),
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
            height: 8,
          ),
          //* Logo
          SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset("assets/Logo.svg"),
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
              children: const [
                SizedBox(
                  width: 25,
                ),
                Text(
                  "My Gardens",
                  style: (TextStyle(
                      fontFamily: "Readex Pro",
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class GardenList extends StatefulWidget {
  String token = "";
  GardenList({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<GardenList> createState() => _GardenListState();
}

class _GardenListState extends State<GardenList> {
  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGardenList();
  }

  //? get the garden list
  getGardenList() async {
    const url = "http://soilanalysis.loca.lt/v1/garden/list";
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.token}'});
    var item = jsonDecode(response.body);

    setState(() {
      data = item["data"];
      gardenCount = data.length;
      isLoading = false;
    });
  }

  List data = [];
  bool isLoading = true;
  int gardenCount = 0;
  @override
  Widget build(BuildContext context) {
    //! if the app is getting the data from the api show loading widget
    return isLoading
        ? Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Color(0xff669D6B),
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedTextKit(animatedTexts: [
                  TyperAnimatedText("Loading...",
                      curve: Curves.linear,
                      textStyle: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold))
                ]),
              ],
            ),
          )

        //? Show the garden List
        : Flexible(
            child: ListView.builder(
                itemCount: gardenCount < 3 ? gardenCount + 1 : 3,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  //* AddGarden card at the end of the list if gardenCount is less than 3
                  if (index == gardenCount && gardenCount < 3) {
                    return const AddGarden();
                  }
                  //* if the list is 3, fill all with the garden cards

                  return GardenCard(
                    gardenID: "${data[index]["_id"]}",
                    gardenName: "${data[index]["name"]}",
                  );
                }),
          );
  }
}
