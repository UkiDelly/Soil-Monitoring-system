import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/porivder/garden.dart';

import '../../../models/garden.dart';

class GardenList extends ConsumerWidget {
  const GardenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider에서 값 가져오기
    AsyncValue<List<Garden>> data = ref.watch(gardnenListProvider);

    return data.when(

        //* 데이터가 존재할시
        data: (data) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                //
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width - 10,
                  //
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),

                      // 그림자
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 5,
                            color: Colors.grey),
                      ]),
                  //
                  child: Center(
                      child: Text(
                    data[index].name,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  )),
                );
              },
            ),
          );
        },

        //! 에러가 발생할시
        error: (error, stack) {
          return Center(
            child: Text(error.toString()),
          );
        },

        //? 로딩중일시
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()));
  }
}
