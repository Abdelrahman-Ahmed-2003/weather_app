import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:weather_app/componant/textWithShadow.dart';

class Data extends StatelessWidget {
  String time;
  Color color;
  double temp;
  String humidity;
  String wind;
  String icon;
  String condition;

  Data({super.key,this.time = '', required this.color,required this.temp,required this.humidity,required this.wind,required this.icon,required this.condition});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextWithShadow(text: time, font: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextWithShadow(
                    text: condition,
                    font: 20),
                CachedNetworkImage(
                  //fit: BoxFit.cover,
                  imageUrl:
                      icon,
                  scale: 0.6,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
            TextWithShadow(
                text: "${temp.toInt()}°",
                font: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image(
                      height: screenHeight * 0.05,
                      image: const AssetImage("lib/images/drop.png"),
                    ),
                    TextWithShadow(
                        text:
                            humidity,
                        font: 20),
                    TextWithShadow(text: "Humidity", font: 20),
                  ],
                ),
                Column(
                  children: [
                    Image(
                      height: screenHeight * 0.05,
                      image: const AssetImage("lib/images/wind.png"),
                    ),
                    TextWithShadow(
                        text:
                            wind,
                        font: 20),
                    TextWithShadow(text: "Wind KP/H", font: 20)
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
