import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thesis/models/sensor_data.dart';
import 'package:thesis/provider/sensor_data.dart';

class ShowSensorData extends ConsumerStatefulWidget {
  Function(List<Datum> sensorDataList) callback;
  ShowSensorData({Key? key, required this.callback}) : super(key: key);

  @override
  ConsumerState<ShowSensorData> createState() => _ShowSensorDataState();
}

class _ShowSensorDataState extends ConsumerState<ShowSensorData> {
  // Page
  PageController pageController = PageController(initialPage: 0);
  int pages = 0;

  @override
  Widget build(BuildContext context) {
    // get the sensor list
    AsyncValue<List<List<Datum>>> sensorData = ref.watch(sensorProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    //
    return sensorData.when(
        data: (data) {
          // set the pages again
          setState(() {
            pages = data.length;
          });

          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: pages,
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
                        latestData.npk(screenWidth * 50),

                        //
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //? Left side
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //* temperature
                                latestData.temperature(screenWidth * 0.45),
                                latestData.humidityLevel(screenWidth * 0.45)
                              ],
                            ),

                            //? Right side
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                latestData.pH(screenWidth * 0.5),
                                latestData.moistureLevel(screenWidth * 0.5)
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
                      count: pages))
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
