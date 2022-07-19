import 'package:flutter/material.dart';
import 'package:thesis/views/Garden%20List/widget/garden_list.dart';

// ignore: must_be_immutable
class GardenListPage extends StatelessWidget {
  const GardenListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            children: [
              //
              const SizedBox(
                height: 10,
              ),

              //* Logo
              //Logo
              Center(
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/Logo/Logo.png',
                    height: 100,
                  ),
                ),
              ),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //

                  // My Garden
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "My Garden",
                      style: TextStyle(fontSize: 45),
                    ),
                  ),

                  //* Create new garden button
                  IconButton(
                      iconSize: 50,
                      splashColor: Colors.transparent,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                      ))
                ],
              ),

              //* Garden list
              const GardenList()
            ],
          ),
        ),
      ),
    );
  }
}
