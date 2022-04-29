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
        nSpot.add(FlSpot(
            (i + 1), sensorList[i.toInt()]['nitrogen'].toDouble()));
        pSpot.add(FlSpot(
            (i + 1), sensorList[i.toInt()]['phosphorous'].toDouble()));
        kSpot.add(FlSpot(
            (i + 1), sensorList[i.toInt()]['potassium'].toDouble()));
        phSpot
            .add(FlSpot((i + 1), sensorList[i.toInt()]['pH'].toDouble()));
        tempSpot.add(FlSpot(
            (i + 1), sensorList[i.toInt()]['temperature'].toDouble()));
        moistureSpot.add(FlSpot(
            (i + 1), sensorList[i.toInt()]['moisture'].toDouble()));
        humiditySpot.add(FlSpot(
            (i + 1), sensorList[i.toInt()]['humidity'].toDouble()));
      }
    } else {
      List reverseList = sensorList.reversed.toList();
      //if sensor data list is greater than 7
      for (double i = 0; i < sensorList.length; i++) {
        nSpot.add(
            FlSpot((i + 1), reverseList[i.toInt()]['nitrogen'].toDouble()));
        pSpot.add(
            FlSpot((i + 1), reverseList[i.toInt()]['phosphorous'].toDouble()));
        kSpot.add(
            FlSpot((i + 1), reverseList[i.toInt()]['potassium'].toDouble()));
        phSpot.add(FlSpot((i + 1), reverseList[i.toInt()]['pH'].toDouble()));
        tempSpot.add(
            FlSpot((i + 1), reverseList[i.toInt()]['temperature'].toDouble()));
        moistureSpot.add(
            FlSpot((i + 1), reverseList[i.toInt()]['moisture'].toDouble()));
        humiditySpot.add(
            FlSpot((i + 1), reverseList[i.toInt()]['humidity'].toDouble()));
      }
    }
  }
}
