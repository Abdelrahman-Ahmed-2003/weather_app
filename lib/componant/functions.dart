import 'package:flutter/material.dart';
import 'package:weather_app/model/model.dart';

String editTime(String time) {
    List<String> dateTimeParts = time.split(" ");
    List<String> timeParts = dateTimeParts[1].split(":");
    return timeParts[0];
  }

  Hour checkTime(hours) {
    print("in check time");
    int hourNow = TimeOfDay.now().hour;
    for (int i = 0; i < hours.length; ++i) {
      if (int.parse(editTime(hours[i].time)) == hourNow) {
        print("in end of check time return hour[i]");
        return hours[i];
      }
    }
    print("in end of check time return hour");
    return Hour();
  }