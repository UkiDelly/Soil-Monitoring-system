// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndialog/ndialog.dart';
import 'package:thesis/models/enum.dart';
import 'package:thesis/views/New%20Garden/widgets/inputs.dart';

import '../loading.dart';
import '../../models/garden.dart';
import 'plants.dart';

class AddNewGarden extends ConsumerStatefulWidget {
  Function() callback;
  String token, userId;
  AddNewGarden(
      {required this.callback,
      required this.userId,
      required this.token,
      Key? key})
      : super(key: key);

  @override
  ConsumerState<AddNewGarden> createState() => _AddNewGardenState();
}

class _AddNewGardenState extends ConsumerState<AddNewGarden> {
  //
  late Garden garden;

  //
  callBack(Garden garden) {
    setState(() {
      this.garden = garden;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //unfocuse eveything if tap the background
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // App bar
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          // Cancel button
          leading: TextButton(
              //disable splash
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pop(context)),
          leadingWidth: 90,

          elevation: 0,
          actions: [
            // Add button
            TextButton(
                //disable splash
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () async {
                  if (newGardenInputFormKey.currentState!.validate()) {
                    // show load
                    CustomProgressDialog loadingDialog = CustomProgressDialog(
                      context,
                      blur: 10,
                      dismissable: false,
                      loadingWidget: const Center(child: LoadingPage()),
                    );
                    loadingDialog.show();

                    //
                    if (garden.plant == Plant.none) {
                      _showToast(context, "Please select a plant.");
                      return;
                    }

                    // create new Garden
                    bool created = await garden.createGarden();

                    loadingDialog.dismiss();

                    if (created) {
                      _showToast(context, "Successfully created a new Garden!");
                      Future.delayed(const Duration(seconds: 500), () {
                        Navigator.of(context).pop();
                      });
                    }
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                      color: Color(0xfffefefe),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),

        backgroundColor: Theme.of(context).colorScheme.primary,

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),

                NewGardenInput(
                  callBack: (Garden garden) => callBack(garden),
                ),

                const Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 3,
                ),

                // Choose plant
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("Plant",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                ),

                //

                //Plant Card
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: PlantCard(
                    callback: ((plant) {
                      setState(() {
                        garden.setPlant = plant;
                      });
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showToast(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
    ),
  );
}
