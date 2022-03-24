// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/provider.dart';

class WebGardenCard extends ConsumerWidget {
  int index;
  String name;
  WebGardenCard({Key? key, required this.index, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.watch(selectionProvider).index);
    return Card(
      color: ref.watch(selectionProvider).index == (index - 1)
          ? const Color(0xff528966)
          : const Color(0xff669D6B),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: SizedBox(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Index of the list
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "#$index",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),

          //* Garden Name
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color.fromARGB(255, 246, 245, 245),
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          )
        ],
      )),
    );
  }
}
