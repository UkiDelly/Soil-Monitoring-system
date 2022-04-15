class SingleSensorData {
  final Map<String, double> npk;

  final double temp, ph, humidity, moisture;

  SingleSensorData({
    required this.npk,
    required this.temp,
    required this.ph,
    required this.humidity,
    required this.moisture,
  });
}
