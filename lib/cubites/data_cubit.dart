import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/location/current_location.dart';
import 'package:intl/intl.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());
  Position? position;
  Model? model;
  List<String> week = [];

  getLocation() async {
    CurrentLocation location = CurrentLocation();
    position = await location.determinePosition();
    emit(DataLoaded());
  }

  getWeather() {
    if (position != null) {
      WeatherApi api = WeatherApi();
      api.fetchWeather(position!.latitude, position!.longitude).then((value) {
        model = value;
        print(
            "***************************************************updated data");
        emit(DataLoaded());
      }).catchError((error) {
        print('Error fetching weather data: $error');
        emit(DataError(error.toString()));
      });
    } else {
      print('Position is null');
      emit(DataError('Position is null'));
    }
  }

  setposition(Position position) {
    this.position = position;
    emit(SetPosition());
  }

  getposition() {
    return position;
  }

  void setDays() {
    if (model!.forecast == null || model!.forecast!.forecastday == null) {
      print("Model or forecast data is null");
      emit(DataError("Model or forecast data is null"));
      return;
    }

    week.clear(); // Clear previous data
    for (var i = 1; i < model!.forecast!.forecastday!.length; i += 1) {
      var day = DateTime.now().add(Duration(days: i));
      week.add(DateFormat('EEEE').format(day));
      print(DateFormat('EEEE').format(day));
    }
    print("set days**************************************");

    emit(SetDate());
  }
}
