import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:thesis/models/enum.dart';
import 'package:thesis/models/garden.dart';

class NewGardenInput extends StatefulWidget {
  final Function(Garden garden) callBack;
  const NewGardenInput({
    Key? key,
    required this.callBack,
  }) : super(key: key);

  @override
  State<NewGardenInput> createState() => _NewGardenInputState();
}

final newGardenInputFormKey = GlobalKey<FormState>();

class _NewGardenInputState extends State<NewGardenInput> {
  // controllers
  TextEditingController nameController = TextEditingController(),
      noteController = TextEditingController();
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
  }

  doneEnter() {
    Garden garden = Garden(
        name: nameController.text,
        notes: noteController.text,
        plant: Plant.none);

    widget.callBack(garden);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: newGardenInputFormKey,
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
