// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndialog/ndialog.dart';
import 'package:thesis/main.dart';
import 'package:thesis/views/add%20new%20garden/plants.dart';
import '../../loading.dart';
import '../../models/garden.dart';

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
  //text controller
  var nameController = TextEditingController(),
      noteController = TextEditingController();
  String selectedPlants = '';
  late bool isDarkMode;

  getPlantName(plantName) {
    setState(() {
      selectedPlants = plantName;
    });
  }

  @override
  void initState() {
    super.initState();
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
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
              onPressed: () {
                widget.callback();
                Navigator.of(context).pop();
              }),

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
                  if (_formKey.currentState!.validate()) {
                    // show load
                    CustomProgressDialog loadingDialog = CustomProgressDialog(
                      context,
                      blur: 10,
                      dismissable: false,
                      loadingWidget: const Center(child: LoadingPage()),
                    );
                    loadingDialog.show();

                    if (selectedPlants == '') {
                      _showToast(context, "Please select a plant.");
                      return;
                    }
                    Garden garden =
                        Garden(token: widget.token, userId: widget.userId);

                    // create new Garden
                    bool created = await garden.createGarden(
                        name: nameController.text,
                        notes: noteController.text,
                        plant: selectedPlants);

                    loadingDialog.dismiss();

                    if (created) {
                      _showToast(context, "Successfully created a new Garden!");
                      Future.delayed(const Duration(milliseconds: 500), () {
                        widget.callback();
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

        backgroundColor: isDarkMode ? const Color(0xff4f7c53) : mainColor,

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),

                inputs(),

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
                    callback: ((String plantName) => getPlantName(plantName)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  Widget inputs() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            // Name
            const Center(
              child: Text(
                "Name",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),

            // Name text field
            Center(
              child: SizedBox(
                width: 300,
                child: TextFormField(
                  style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.white),
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter a name",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Colors.red, width: 3),
                    ),
                  ),
                  validator: (name) {
                    if (name == "") {
                      return "Please enter a name";
                    }
                    return null;
                  },
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Center(
              child: Text(
                "Notes",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),

            // notes
            Center(
              child: TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: noteController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Enter a note",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
                  fillColor: Colors.white,
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ),
          ],
        ));
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
