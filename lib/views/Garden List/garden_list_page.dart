import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesis/views/Garden%20List/widget/garden_list.dart';

// ignore: must_be_immutable
class GardenListPage extends StatelessWidget {
  const GardenListPage({Key? key}) : super(key: key);

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
          child: Column(
            children: const [

              //
              GardenList()
            ],
          ),
        ),
      ),
    );
  }
}
