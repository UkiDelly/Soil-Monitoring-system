import 'package:flutter_riverpod/flutter_riverpod.dart';


final selectionProvider =
    StateProvider<dynamic>((ref) => SelectGarden(false, null));
final gardenIdListProvider = StateProvider<dynamic>((ref) => []);

class SelectGarden {
  bool isSelected;
  int? index;

  SelectGarden(this.isSelected, this.index);
}
