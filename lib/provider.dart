import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider = StateProvider<String>((ref) => "");
final gardenIDProvider = StateProvider<String>((ref) => "");
final selectionProvider =
    StateProvider<dynamic>((ref) => SelectGarden(false, null));

class SelectGarden {
  bool isSelected;
  int? index;

  SelectGarden(this.isSelected, this.index);
}
//user ID
final userIdProvider = StateProvider<String>(
  (ref) => "",
);
