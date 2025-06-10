import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/componant/functions.dart';
import 'package:weather_app/componant/textWithShadow.dart';
import 'package:weather_app/cubites/data_cubit.dart';

void bottomSheet(BuildContext context, int i, DataCubit cubit) {
  showModalBottomSheet(
    backgroundColor: const Color(0xff331C71),
    context: context,
    isScrollControlled: true, // Allows better height control
    useSafeArea: true,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false, // Prevents full screen expansion
        initialChildSize: 0.4, // Initial height (40% of screen)
        minChildSize: 0.2, // Minimum height (20%)
        maxChildSize: 0.8, // Maximum height (80%)
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xff331C71),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    DateFormat('EEEE').format(DateTime.now().add(Duration(days: i))),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController, // To make list scrollable
                    itemCount: 24, // Number of items in the list
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextWithShadow(
                              text:
                                  '${editTime(cubit.model?.forecast?.forecastday?[i].hour?[index].time ?? '')}:00',
                              font: 20),
                          const Spacer(),
                          CachedNetworkImage(
                            imageUrl:
                                'https:${cubit.model?.forecast?.forecastday?[i].hour?[index].condition?.icon ?? ''}',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          const Spacer(),
                          TextWithShadow(
                              text:
                                  '${cubit.model?.forecast?.forecastday?[i].hour?[index].tempC?.toInt() ?? 0}°',
                              font: 20),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.white,
                        thickness: 1,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
