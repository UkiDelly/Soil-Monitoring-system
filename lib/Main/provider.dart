import 'package:flutter_riverpod/flutter_riverpod.dart';

//user ID
final userIDProvider = StateProvider<String>((ref) => "");
final tokenProvider = StateProvider<String>((ref) => "");
final gardenIDProvider = StateProvider<String>((ref) => "");
final selectionProvider =
    StateProvider<dynamic>((ref) => SelectGarden(false, null));
final sensorIdListProvider = StateProvider<List>((ref) => []);
final webAddgardenActiveProvider = StateProvider<bool>((ref) => false);

class SelectGarden {
  bool isSelected;
  int? index;

  SelectGarden(this.isSelected, this.index);
}
