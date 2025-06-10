import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/componant/Bottom_Sheet.dart';
import 'package:weather_app/componant/centeredContainer.dart';
import 'package:weather_app/cubites/data_cubit.dart';

class WeekPage extends StatelessWidget {
  const WeekPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DataCubit>();
    List<String> week = List.from(cubit.week);
    return BlocConsumer<DataCubit, DataState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(backgroundColor: const Color(0xff331C71)),
          backgroundColor: const Color(0xff331C71),
          body: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Column(children: [
              InkWell(
                onTap: () {
                  bottomSheet(context, 1, cubit);
                },
                child: Data(
                    color: const Color(0xff5842A9),
                    time: cubit.week[0],
                    temp: cubit.model?.forecast!.forecastday![1].day!.avgtemp ??
                        0.0,
                    humidity:
                        '${cubit.model?.forecast?.forecastday?[1].day!.avghumidity ?? 0}',
                    wind:
                        '${cubit.model?.forecast?.forecastday?[1].day!.maxwindK ?? 0}',
                    condition: cubit.model?.forecast?.forecastday?[1].day
                            ?.condition?.text ??
                        '',
                    icon:
                        'https:${cubit.model?.forecast?.forecastday?[1].day?.condition?.icon ?? ''}'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SafeArea(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: cubit.model?.forecast?.forecastday?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < 2) {
                        return Container();
                      }
                      return InkWell(
                        onTap: () {
                          bottomSheet(context, index, cubit);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff5842A9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    "${DateFormat('EEEE').format(DateTime.now().add(Duration(days: index)))}",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                CachedNetworkImage(
                                    imageUrl:
                                        ('http:${cubit.model?.forecast!.forecastday![index].day?.condition?.icon ?? ''}'),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error)),
                                Text(
                                  "${cubit.model?.forecast!.forecastday![index].day?.condition!.text}",
                                ),
                                Text(
                                    "${cubit.model?.forecast!.forecastday![index].day?.avgtemp!.toInt()}°",
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ]),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
