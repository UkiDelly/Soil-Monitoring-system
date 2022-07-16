import 'package:fl_chart/fl_chart.dart';

class HistoryOfSensorData {
  final sensorList;
  List<FlSpot> nSpot = [],
      pSpot = [],
      kSpot = [],
      phSpot = [],
      tempSpot = [],
      moistureSpot = [],
      humiditySpot = [];

  HistoryOfSensorData({required this.sensorList});

  createHistory() {
    //if the sensor data list is less than 7

    if (sensorList.length < 7) {
      for (double i = 0; i < sensorList.length; i++) {
        // print(sensorList[i.toInt()]);
        nSpot
            .add(FlSpot((i + 1), sensorList[i.toInt()]['nitrogen'].toDouble()));
        pSpot.add(
            FlSpot((i + 1), sensorList[i.toInt()]['phosphorous'].toDouble()));
        kSpot.add(
            FlSpot((i + 1), sensorList[i.toInt()]['potassium'].toDouble()));
        phSpot.add(FlSpot((i + 1), sensorList[i.toInt()]['pH'].toDouble()));
        tempSpot.add(
            FlSpot((i + 1), sensorList[i.toInt()]['temperature'].toDouble()));
        moistureSpot
            .add(FlSpot((i + 1), sensorList[i.toInt()]['moisture'].toDouble()));
        humiditySpot
            .add(FlSpot((i + 1), sensorList[i.toInt()]['humidity'].toDouble()));
      }
    } else {
      // List reverseList = sensorList.reversed.toList();
      int seventhFromLast = (sensorList.length - 7);

      List tempList = [];

      for (int i = 0; i < 7; i++) {
        tempList.add(sensorList[seventhFromLast++]);
      }

      

      //if sensor data list is greater than 7
      for (double i = 0; i < tempList.length; i++) {
        nSpot.add(FlSpot((i + 1), tempList[i.toInt()]['nitrogen'].toDouble()));
        pSpot.add(
            FlSpot((i + 1), tempList[i.toInt()]['phosphorous'].toDouble()));
        kSpot.add(FlSpot((i + 1), tempList[i.toInt()]['potassium'].toDouble()));
        phSpot.add(FlSpot((i + 1), tempList[i.toInt()]['pH'].toDouble()));
        tempSpot.add(
            FlSpot((i + 1), tempList[i.toInt()]['temperature'].toDouble()));
        moistureSpot
            .add(FlSpot((i + 1), (tempList[i.toInt()]['moisture'].toDouble()/1000)));
        humiditySpot
            .add(FlSpot((i + 1), tempList[i.toInt()]['humidity'].toDouble()));
      }
    }
  }
}
