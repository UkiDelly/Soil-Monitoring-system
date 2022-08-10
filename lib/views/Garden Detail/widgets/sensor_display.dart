import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thesis/models/sensor_data.dart';
import 'package:thesis/porivder/sensor_data.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/humidity.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/moisture.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/npk_status.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/ph_level.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/tempurature.dart';

class ShowSensorData extends ConsumerStatefulWidget {
  Function(List<Datum> sensorDataList) callback;
  ShowSensorData({Key? key, required this.callback}) : super(key: key);

  @override
  ConsumerState<ShowSensorData> createState() => _ShowSensorDataState();
}

class _ShowSensorDataState extends ConsumerState<ShowSensorData> {
  // Page
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // get the sensor list
    AsyncValue<List<List<Datum>>> sensorData = ref.watch(sensorProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    //
    return sensorData.when(
        data: (data) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: data.length,
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // callback after build
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      widget.callback(data[index]);
                    });

                    // get the last data
                    SingleSensorData latestData = SingleSensorData(
                        n: data[index].last.nitrogen,
                        p: data[index].last.phosphorous,
                        k: data[index].last.potassium,
                        ph: data[index].last.pH,
                        temp: data[index].last.temperature,
                        moisture: double.parse(
                            data[index].last.moisture.toStringAsFixed(2)),
                        humidity: data[index].last.humidity);

                    return Column(
                      children: [
                        //* NPK
                        NPKstatus(
                            dataMap: latestData.getNPK,
                            width: screenWidth * 50),

                        //
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //? Left side
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //* temperature
                                Temp(
                                    temp: latestData.temp,
                                    width: screenWidth * 0.45),

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
                                PhLevel(
                                    ph: latestData.ph,
                                    width: screenWidth * 0.5),

                                //* Moisture
                                MoistureLevel(
                                    moisture: latestData.moisture,
                                    width: screenWidth * 0.5),
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
                      count: data.length))
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
