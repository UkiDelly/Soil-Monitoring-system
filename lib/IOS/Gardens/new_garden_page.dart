import 'package:flutter/material.dart';

class AddNewGarden extends StatefulWidget {
  AddNewGarden({Key? key}) : super(key: key);

  @override
  State<AddNewGarden> createState() => _AddNewGardenState();
}

class _AddNewGardenState extends State<AddNewGarden> {
  void initState() {
    super.initState();
  }

  //text controller
  var nameControl = TextEditingController();

  Widget build(BuildContext context) {
    @override
    var name;

    return GestureDetector(
      //unfocuse eveything if tap the background
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        // App bar
        appBar: AppBar(
          backgroundColor: const Color(0xff669D6B),

          // Cancel button
          leading: TextButton(
            //disable splash
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          leadingWidth: 90,

          elevation: 0,
          actions: [
            // Add button
            TextButton(
                //disable splash
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {},
                child: const Text(
                  "Add",
                  style: TextStyle(
                      color: Color(0xfffefefe),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),

        backgroundColor: const Color(0xff669D6B),

        body: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              const Padding(
                padding: EdgeInsets.only(left: 45, bottom: 10),
                child: Text(
                  "Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              // Name text field
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: nameControl,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xfffefefe),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                ),
              ),

              // Avail sensor

              const SizedBox(
                height: 500,
              )
            ],
          ),
        ),
      ),
    );
  }
}
