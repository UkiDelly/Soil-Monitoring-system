import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/provider.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (ctx, ref, child) {
            final token = ref.watch(tokenProvider).toString();
            return _TestState(token: token);
          },
        ),
      ),
    );
  }
}

class _TestState extends StatefulWidget {
  var token = "";
  _TestState({Key? key, required this.token}) : super(key: key);

  @override
  State<_TestState> createState() => __TestStateState();
}

class __TestStateState extends State<_TestState> {
  int counter = 1;
  List data = [];

  fetchData() async {
    const url = "http://soilanalysis.loca.lt/v1/garden/list";
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.token}'});
    var item = jsonDecode(response.body);
    setState(() {
      
      data = item["data"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (context, index) =>
              const ListTile(tileColor: Colors.red, title: Text(""))),
    );
  }
}
