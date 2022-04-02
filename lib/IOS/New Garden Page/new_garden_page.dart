import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNewGarden extends StatefulWidget {
  const AddNewGarden({Key? key}) : super(key: key);

  @override
  State<AddNewGarden> createState() => _AddNewGardenState();
}

class _AddNewGardenState extends State<AddNewGarden> {
  @override
  void initState() {
    super.initState();
  }

  //text controller
  var nameControl = TextEditingController(),
      noteControl = TextEditingController();

  createGarden() {
    const url = "http://localhost:3000/v1/garden/create";
    var response = http.post(Uri.parse(url),
        body: {"name": nameControl.text, "notes": noteControl.text});

    //TODO: finish the create garden
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

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Name
              const Text(
                "Name",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              // Name text field
              SizedBox(
                width: 300,
                child: TextField(
                  controller: noteControl,
                  decoration: const InputDecoration(
                    hintText: "Enter a name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "Notes",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              // notes
              SizedBox(
                width: 350,
                height: 400,
                child: TextField(
                  controller: nameControl,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: "Enter a note",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
