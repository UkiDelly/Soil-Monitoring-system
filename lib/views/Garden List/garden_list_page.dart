import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/porivder/garden.dart';
import 'package:thesis/porivder/user_id.dart';
import 'package:thesis/views/Garden%20List/widget/garden_list.dart';
import 'package:thesis/views/New%20Garden/new_garden_page.dart';

import '../../porivder/token.dart';

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
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    ),
                  ),

                  //* Create new garden button
                  Consumer(
                    builder: (context, ref, child) => IconButton(
                        iconSize: 50,
                        splashColor: Colors.transparent,

                        //
                        onPressed: () => Navigator.of(context)
                            .push(PageTransition(
                                child: AddNewGarden(
                                    userId: ref.watch(userIDProvider),
                                    token: ref.watch(tokenProvider)),
                                type: PageTransitionType.rightToLeft))
                            .then((value) => ref.refresh(gardnenListProvider)),
                        icon: const Icon(
                          Icons.add,
                        )),
                  )
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
