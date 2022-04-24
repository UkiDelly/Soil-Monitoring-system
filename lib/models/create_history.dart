import 'package:fl_chart/fl_chart.dart';
import 'package:thesis/models/single_sensor.dart';

class HistoryOfSensorData extends Sensor {
  List<FlSpot> nSpot = [],
      pSpot = [],
      kSpot = [],
      phSpot = [],
      tempSpot = [],
      moistureSpot = [],
      humiditySpot = [];

  HistoryOfSensorData({required token, required gardenId})
      : super(token: token, gardenId: gardenId);

  createHistory() {
    //if the sensor data list is less than 7

    if (super.sensorList.length < 7) {
      for (double i = 0; i < super.sensorList.length; i++) {
        // print(super.sensorList[i.toInt()]);
        nSpot.add(
            FlSpot((i + 1), super.sensorList[i.toInt()]['nitrogen'].toDouble()));
        pSpot.add(FlSpot(
            (i + 1), super.sensorList[i.toInt()]['phosphorous'].toDouble()));
        kSpot.add(
            FlSpot((i + 1), super.sensorList[i.toInt()]['potassium'].toDouble()));
        phSpot.add(FlSpot((i + 1), super.sensorList[i.toInt()]['pH'].toDouble()));
        tempSpot.add(FlSpot(
            (i + 1), super.sensorList[i.toInt()]['temperature'].toDouble()));
        moistureSpot.add(
            FlSpot((i + 1), super.sensorList[i.toInt()]['moisture'].toDouble()));
        humiditySpot.add(
            FlSpot((i + 1), super.sensorList[i.toInt()]['humidity'].toDouble()));
      }
    } else {
      List reverseList = super.sensorList.reversed.toList();
      //if sensor data list is greater than 7
      for (double i = 0; i < super.sensorList.length; i++) {
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
