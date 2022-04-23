class Cassave {
  final double nitrogen, phosphorous, potassium, ph;
  static String name = "Cassave";

  Cassave({
    required this.nitrogen,
    required this.phosphorous,
    required this.potassium,
    required this.ph,
  });

  Map<String, dynamic> getNitrogen() {
    double fertilizer;

    if (nitrogen <= 2) {
      fertilizer = (55 / .46) / 50;
      return {
        'status': "Low",
        'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"
      };
    } else if (nitrogen <= 3.5) {
      fertilizer = (40 / .46) / 50;
      return {
        'status': "Meduim",
        'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"
      };
    }
    fertilizer = (50 / .46) / 50;
    return {
      'status': "High",
      'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"
    };
  }

  Map<String, dynamic> getPhosphorous() {
    double fertilizer;

    if (phosphorous <= 10) {
      fertilizer = (45 / .46) / 50;
      return {
        'status': "Low",
        'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"
      };
    } else if (phosphorous <= 15) {
      fertilizer = (30 / .46) / 50;
      return {
        'status': "Meduim",
        'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"
      };
    }
    fertilizer = (16 / .46) / 50;
    return {
      'status': "High",
      'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"
    };
  }

  Map<String, dynamic> getPotassium() {
    double fertilizer;
    if (potassium <= 75) {
      fertilizer = (90 / 0.60) / 50;
      return {
        'status': 'Deficient',
        'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"
      };
    } else {
      fertilizer = (45 / 0.60) / 50;
      return {
        'status': 'Sufficient',
        'fertilizer': "${fertilizer.toStringAsFixed(2)} bags"
      };
    }
  }

  String getPh() {
    if (ph >= 4 && ph <= 5) {
      return "2T/Ha Organic Fertilizer";
    } else if (ph <= 6) {
      return "1T/Ha Organic Fertilizer";
    } else {
      return "No need to fertilize";
    }
  }
}
