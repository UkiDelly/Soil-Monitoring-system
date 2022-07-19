import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thesis/models/sensor_data.dart';
import 'package:thesis/porivder/sensor_data.dart';

class ShowSensorData extends ConsumerStatefulWidget {
  const ShowSensorData({Key? key}) : super(key: key);

  @override
  ConsumerState<ShowSensorData> createState() => _ShowSensorDataState();
}

class _ShowSensorDataState extends ConsumerState<ShowSensorData> {
  // Page
  PageController page_controller = PageController(initialPage: 0);
  int pages = 0;

  @override
  void initState() {
    super.initState();
  }

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

          return PageView.builder(
            itemCount: pages,
            controller: page_controller,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              // get the last data
              SingleSensorData latestData = SingleSensorData(
                  n: data[index].last.nitrogen,
                  p: data[index].last.phosphorous,
                  k: data[index].last.potassium,
                  ph: data[index].last.pH,
                  temp: data[index].last.temperature,
                  moisture: data[index].last.moisture,
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
                          latestData.temperature(screenWidth * 0.5)
                        ],
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  // Indicator
                  SizedBox(
                      height: 10,
                      child: SmoothPageIndicator(
                          effect:
                              const WormEffect(activeDotColor: Colors.black),
                          controller: page_controller,
                          count: pages))
                ],
              );
            },
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
