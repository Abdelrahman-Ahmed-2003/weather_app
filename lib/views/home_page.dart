import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/componant/centeredContainer.dart';
import 'package:weather_app/componant/functions.dart';
import 'package:weather_app/componant/hourlyData.dart';
import 'package:weather_app/componant/nameApp.dart';
import 'package:weather_app/connection/internetConection.dart';
import 'package:weather_app/cubites/data_cubit.dart';
import 'package:weather_app/notification/localNorification.dart';
import 'package:workmanager/workmanager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInternet = false;

  Future<String> checkConnection() async {
    return await checkInternetConnection();
  }

  @override
  initState() {
    super.initState();
    print("in init stateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");

    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        print('No Internettttttttttttt Connectionnnnnnnnnnnnnnnnn');
        setState(() {
          isInternet = false;
        });
      } else {
        print('Internet Connection availableeeeeeeeeeeeeeeeeeeee');
        setState(() {
          isInternet = true;
        });
      }
      // Received changes in available connectivity types!
    });

    print("dddddddddddddddddddddddddddddddddddddddddddddddddddddd");

    listentoNotification();
    var cubit = context.read<DataCubit>();

    cubit.getLocation().then((_) {
      cubit.getWeather();
    });

    // Register the periodic task
    /*Workmanager().registerPeriodicTask(
          '1',
          'simplePeriodicTask',
          frequency: const Duration(hours: 1),
        );

        // Register another periodic task with a different frequency
        Workmanager().registerPeriodicTask(
          '2',
          'anotherPeriodicTask',
          frequency: const Duration(hours: 2),
        );

        // Register a one-off task
        Workmanager().registerOneOffTask(
          '3',
          'simpleOneOffTask',
          inputData: {
            'title': 'One-Off Weather Update',
            'body': 'Current weather condition: Sunny', // Replace with actual weather data
            'payload': 'one_off_weather_payload',
          },
        );*/
  }

  // Listen to notification clicks
  listentoNotification() {
    print("Listening to notification");
    /*LocalNotification.onClick.stream.listen((event) {
      MaterialPageRoute(builder: (context) => const AnotherPage(payload:event));
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<DataCubit>();
        if (!isInternet) {
          return const Scaffold(
            backgroundColor: Color(0xff5842A9),
            body: Center(child: Text('not inter net'),)
          );
        } else if (cubit.model == null || cubit.position == null) {
          return const Scaffold(
            backgroundColor: Color(0xff5842A9),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xff5842A9),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // AppBar Section
                AppName(cubit: cubit),

                // Humidity and Wind Information Section

                Data(
                    color: const Color(0xff331C71),
                    time: cubit.model?.location?.localtime ?? 'not founded',
                    temp: cubit.model?.current?.tempC ?? 0.0,
                    humidity:
                        "${checkTime(cubit.model?.forecast?.forecastday?[0].hour ?? []).humidity ?? 0}",
                    wind:
                        "${checkTime(cubit.model?.forecast?.forecastday?[0].hour ?? []).windKph ?? 0}",
                    condition: cubit.model?.current?.condition?.text ?? '',
                    icon:
                        'https:${cubit.model?.current?.condition?.icon ?? ''}'),

                // Date and Time

                // Buttons for Day View and 3-Day Forecast
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 33, 75, 243)),
                        ),
                        onPressed: () {},
                        child: const Text("Today",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 91, 131, 116)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/WeekPage');
                          cubit.setDays();
                        },
                        child: const Text("2-Day Forecasts",
                            style: TextStyle(color: Colors.white))),
                  ],
                ),

                // Hourly Forecast (Horizontal List)
                HourlyData(cubit: cubit),
              ],
            ),
          )),
        );
      },
    );
  }
}
