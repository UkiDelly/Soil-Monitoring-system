import 'package:flutter_riverpod/flutter_riverpod.dart';

//user ID
final userIDProvider = StateProvider<String>((ref) => "");
final tokenProvider = StateProvider<String>((ref) => "");
final gardenIDProvider = StateProvider<String>((ref) => "");
final selectionProvider =
    StateProvider<dynamic>((ref) => SelectGarden(false, null));
final gardenIdListProvider = StateProvider<dynamic>((ref) => []);
final webAddgardenActiveProvider = StateProvider<bool>((ref) => false);
final sensorDataProvider = StateProvider<dynamic>((ref) => {});

class SelectGarden {
  bool isSelected;
  int? index;

  SelectGarden(this.isSelected, this.index);
}
