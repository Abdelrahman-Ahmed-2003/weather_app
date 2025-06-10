import 'package:flutter/material.dart';
import 'package:weather_app/componant/textWithShadow.dart';
import 'package:weather_app/cubites/data_cubit.dart';
import 'package:weather_app/notification/localNorification.dart';

class AppName extends StatelessWidget {
  DataCubit cubit;
  AppName({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWithShadow(text: 'Weather App', font: 20),
        Container(
          height: screenHeight * 0.05,
          width: screenWidth * 0.1,
          decoration: BoxDecoration(
              color: const Color(0xff331C71),
              borderRadius: BorderRadius.circular(12)),
          child: IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () {
              LocalNotification.showPeriodicNot(
                  title: "show minit", body: "not", payload: "dfd");
              cubit.getWeather();
            },
          ),
        ),
      ],
    );
  }

  
}
