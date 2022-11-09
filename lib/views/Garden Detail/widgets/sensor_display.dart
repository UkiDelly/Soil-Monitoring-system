import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thesis/models/sensor_data.dart';
import 'package:thesis/provider/sensor/sensor_data.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/humidity.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/moisture.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/npk_status.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/ph_level.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/tempurature.dart';

import '../../../provider/sensor_data.dart';

class ShowSensorData extends ConsumerWidget {
  // final Function(List<Datum> sensorDataList, List<Datum> lastSensorData)
  //     callback;
  ShowSensorData({Key? key}) : super(key: key);

  // Page
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get the sensor list
    AsyncValue<SensorData> sensorData = ref.watch(sensorProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    final sensor = ref.watch(sensorDataStateProvider.notifier);
    //
    return sensorData.when(
        data: (data) {
          List<Datum> _temp = [data.data[0].last, data.data[1].last, data.data[2].last];

          //
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: data.data.length,
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // callback after build

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      sensor.setDataList = data.data[index];
                      sensor.getAverage(lastSensorData: _temp);
                    });

                    // get the last data
                    SingleSensorData latestData = SingleSensorData(
                        n: data.data[index].last.nitrogen,
                        p: data.data[index].last.phosphorous,
                        k: data.data[index].last.potassium,
                        ph: data.data[index].last.pH,
                        temp: data.data[index].last.temperature,
                        moisture: double.parse(data.data[index].last.moisture.toStringAsFixed(2)),
                        humidity: data.data[index].last.humidity);

                    return Column(
                      children: [
                        //* NPK
                        NPKstatus(dataMap: latestData.getNPK, width: screenWidth * 50),

                        //
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //? Left side
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //* temperature
                                Temp(temp: latestData.temp, width: screenWidth * 0.45),

                                //* Humidity
                                Humidity(
                                  humidity: latestData.humidity,
                                  width: screenWidth * 0.45,
                                )
                              ],
                            ),

                            //? Right side
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //* Ph
                                PhLevel(ph: latestData.ph, width: screenWidth * 0.5),

                                //* Moisture
                                MoistureLevel(
                                    moisture: latestData.moisture, width: screenWidth * 0.5),
                              ],
                            )
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Indicator
              SizedBox(
                  height: 10,
                  child: SmoothPageIndicator(
                      effect: const WormEffect(activeDotColor: Colors.black),
                      controller: pageController,
                      count: data.data.length))
            ],
          );
        },
        error: (error, stack) {
          return Container();
        },
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}
