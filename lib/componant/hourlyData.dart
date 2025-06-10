import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/componant/functions.dart';
import 'package:weather_app/componant/textWithShadow.dart';
import 'package:weather_app/cubites/data_cubit.dart';

class HourlyData extends StatelessWidget {
  DataCubit cubit;
  HourlyData({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight * 0.2,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: cubit.model?.forecast?.forecastday?[0].hour?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: const EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                color: const Color(0xff331C71),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextWithShadow(
                      text:
                          '${editTime(cubit.model?.forecast?.forecastday?[0].hour?[index].time ?? '')}:00',
                      font: 20),
                  CachedNetworkImage(
                    imageUrl:
                        'https:${cubit.model?.forecast?.forecastday?[0].hour?[index].condition?.icon ?? ''}',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  TextWithShadow(
                      text:
                          '${cubit.model?.forecast?.forecastday?[0].hour?[index].tempC?.toInt() ?? 0}°',
                      font: 20),
                ],
              ));
        },
      ),
    );
  }
}
