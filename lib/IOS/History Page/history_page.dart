import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/provider.dart';
import '../../History page Widgets/humidity_history.dart';
import '../../History page Widgets/moisture_history.dart';
import '../../History page Widgets/npk_history.dart';
import '../../History page Widgets/ph_history.dart';
import '../../History page Widgets/temperature.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff669D6B),
        appBar: AppBar(
          backgroundColor: const Color(0xff669D6B),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            "Soil Status History",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Consumer(
          builder: (ctx, ref, child) {
            const sensorId =
                "623bde62d90c4c4fce78124a"; //ref.watch(sensorIDProvider);
            return _History(sensorId: sensorId);
          },
        ));
  }
}

// ignore: must_be_immutable
class _History extends StatefulWidget {
  String sensorId;
  _History({Key? key, required this.sensorId}) : super(key: key);

  @override
  State<_History> createState() => __HistoryState();
}

class __HistoryState extends State<_History> {
  //* Get sensor data

  //TODO: create sensor data history
  getSensorData() {}

  @override
  void initState() {
    super.initState();
    getSensorData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// NPK history
              const SizedBox(
                height: 10,
              ),
              NpkHistory(),

              /// Ph history
              const SizedBox(
                height: 10,
              ),
              PhHistory(),

              /// Moisture history
              const SizedBox(
                height: 10,
              ),
              MoistureHistory(),

              /// Temperature history
              const SizedBox(height: 10),
              TempHistory(),

              /// Humidity history
              const SizedBox(height: 10),
              HumidityHistory()
            ],
          ),
        ),
      ),
    );
  }
}
