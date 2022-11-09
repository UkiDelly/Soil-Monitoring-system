import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/views/Garden%20List/widget/garden_card.dart';

import '../../../models/garden.dart';
import '../../../provider/garden/garden.dart';

class GardenList extends ConsumerWidget {
  const GardenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 다크모드인지 확인

  

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

                return GardenCard(
                  index: index,
                  garden: data[index],
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
        loading: () => const Center(child: CircularProgressIndicator.adaptive()));
  }
}
