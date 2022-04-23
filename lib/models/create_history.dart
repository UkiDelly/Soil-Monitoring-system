import 'package:fl_chart/fl_chart.dart';
class HistoryOfSensorData {
  List<FlSpot> nSpot = [],
      pSpot = [],
      kSpot = [],
      phSpot = [],
      tempSpot = [],
      moistureSpot = [],
      humiditySpot = [];
  final sensorDataList;

  HistoryOfSensorData(this.sensorDataList);

  createHistory() {
    //if the sensor data list is less than 7

    if (sensorDataList.length < 7) {
      for (double i = 0; i < sensorDataList.length; i++) {
        // print(sensorDataList[i.toInt()]);
        nSpot.add(
            FlSpot((i + 1), sensorDataList[i.toInt()]['nitrogen'].toDouble()));
        pSpot.add(FlSpot(
            (i + 1), sensorDataList[i.toInt()]['phosphorous'].toDouble()));
        kSpot.add(
            FlSpot((i + 1), sensorDataList[i.toInt()]['potassium'].toDouble()));
        phSpot.add(FlSpot((i + 1), sensorDataList[i.toInt()]['pH'].toDouble()));
        tempSpot.add(FlSpot(
            (i + 1), sensorDataList[i.toInt()]['temperature'].toDouble()));
        moistureSpot.add(
            FlSpot((i + 1), sensorDataList[i.toInt()]['moisture'].toDouble()));
        humiditySpot.add(
            FlSpot((i + 1), sensorDataList[i.toInt()]['humidity'].toDouble()));
      }
    } else {
      List reverseList = sensorDataList.reversed.toList();
      //if sensor data list is greater than 7
      for (double i = 0; i < sensorDataList.length; i++) {
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
