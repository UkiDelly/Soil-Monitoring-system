class Rice {
  final double nitrogen, phosphorous, potassium, ph;
  static String name = "Rice";

  Rice({
    required this.nitrogen,
    required this.phosphorous,
    required this.potassium,
    required this.ph,
  });

  Map<String, dynamic> getNitrogen() {
    double wetSeason, drySeason;

    if (nitrogen <= 3.5) {
      wetSeason = (80 / 0.46) / 50;
      drySeason = (90 / 0.46) / 50;
      return {
        'status': "Low",
        'fertilizer': {
          "wet": "${wetSeason.toStringAsFixed(2)} bags",
          "dry": "${drySeason.toStringAsFixed(2)} bags"
        }
      };
    } else if (nitrogen <= 4.5) {
      wetSeason = (50 / 0.46) / 50;
      drySeason = (60 / 0.46) / 50;
      return {
        'status': "Meduim",
        'fertilizer': {
          "wet": "${wetSeason.toStringAsFixed(2)} bags",
          "dry": "${drySeason.toStringAsFixed(2)} bags"
        }
      };
    }
    wetSeason = (26 / 0.46) / 50;
    drySeason = (20 / 0.46) / 50;
    return {
      'status': "High",
      'fertilizer': {
        "wet": "${wetSeason.toStringAsFixed(2)} bags",
        "dry": "${drySeason.toStringAsFixed(2)} bags"
      }
    };
  }

  Map<String, dynamic> getPhosphorous() {
    double wetSeason, drySeason;

    if (phosphorous <= 6) {
      wetSeason = drySeason = (50 / .18) / 50;
      return {
        'status': "Low",
        'fertilizer': {
          "wet": "${wetSeason.toStringAsFixed(2)} bags",
          "dry": "${drySeason.toStringAsFixed(2)} bags"
        }
      };
    } else if (phosphorous <= 10) {
      wetSeason = drySeason = (20 / 0.18) / 50;

      return {
        'status': "Meduim",
        'fertilizer': {
          "wet": "${wetSeason.toStringAsFixed(2)} bags",
          "dry": "${drySeason.toStringAsFixed(2)} bags"
        }
      };
    }

    wetSeason = drySeason = (6 / .18) / 50;
    return {
      'status': "High",
      'fertilizer': {
        "wet": "${wetSeason.toStringAsFixed(2)} bags",
        "dry": "${drySeason.toStringAsFixed(2)} bags"
      }
    };
  }

  Map<String, dynamic> getPotassium() {
    double wetSeason, drySeason;
    if (potassium <= 25) {
      wetSeason = drySeason = (60 / 0.60) / 50;
      return {
        'status': 'Deficient',
        'fertilizer': {
          "wet": "${wetSeason.toStringAsFixed(2)} bags",
          "dry": "${drySeason.toStringAsFixed(2)} bags"
        }
      };
    } else {
      wetSeason = drySeason = (22 / 0.60) / 50;
      return {
        'status': 'Sufficient',
        'fertilizer': {
          "wet": "${wetSeason.toStringAsFixed(2)} bags",
          "dry": "${drySeason.toStringAsFixed(2)} bags"
        }
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
