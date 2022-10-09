import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/models/plants/cassave/cassave_model.dart';

final cassaveProvider = StateNotifierProvider<_CassaveNotifier, CassaveModel?>((ref) => _CassaveNotifier());

class _CassaveNotifier extends StateNotifier<CassaveModel?> {
  _CassaveNotifier() : super(null);

  Map getNitrogen() {
    double fertilizer;

    if (state!.nitrogen <= 2) {
      fertilizer = (55 / .46) / 50;

      return {
        'status': "Low",
        'fertilizer': "${fertilizer.toStringAsFixed(2)} bags",
      };
    } else if (state!.nitrogen <= 3.5) {
      fertilizer = (40 / .46) / 50;
      return {
        'status': "Meduim",
        'fertilizer': "${fertilizer.toStringAsFixed(2)} bags",
      };
    }
    fertilizer = (50 / .46) / 50;
    return {
      'status': "High",
      'fertilizer': "${fertilizer.toStringAsFixed(2)} bags",
    };
  }

  Map<String, dynamic> getPhosphorous() {
    double fertilizer;

    if (state!.phosphorous <= 10) {
      fertilizer = (45 / .46) / 50;
      return {'status': "Low", 'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"};
    } else if (state!.phosphorous <= 15) {
      fertilizer = (30 / .46) / 50;
      return {'status': "Meduim", 'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"};
    }
    fertilizer = (16 / .46) / 50;
    return {'status': "High", 'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"};
  }

  Map<String, dynamic> getPotassium() {
    double fertilizer;
    if (state!.potassium <= 75) {
      fertilizer = (90 / 0.60) / 50;
      return {'status': 'Deficient', 'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"};
    } else {
      fertilizer = (45 / 0.60) / 50;
      return {'status': 'Sufficient', 'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"};
    }
  }

  String getPh() {
    if (state!.ph >= 4 && state!.ph <= 5) {
      return "2T/Ha Organic Fertilizer";
    } else if (state!.ph <= 6) {
      return "1T/Ha Organic Fertilizer";
    } else {
      return "No need to fertilize";
    }
  }
}
