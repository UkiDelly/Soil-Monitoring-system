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
        FocusScope.of(context).requestFocus(FocusNode());
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

        body: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              const Padding(
                padding: EdgeInsets.only(left: 45, bottom: 5),
                child: Text(
                  "Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              // Name text field
              Container(
                height: 30,
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: nameControl,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: const BoxDecoration(
                      color: Color(0xfffefefe),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
