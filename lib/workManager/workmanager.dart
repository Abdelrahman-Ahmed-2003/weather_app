import 'package:weather_app/notification/localNorification.dart';
import 'package:workmanager/workmanager.dart'; 
import 'package:timezone/data/latest.dart' as tz;

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Initialize time zones
    tz.initializeTimeZones();

    // Schedule notification
    await LocalNotification.showScheduleNotification(
      title: 'Hourly Weather Update',
      body: 'Current weather condition: Sunny', // Replace with actual weather data
      payload: 'weather_payload',
    );

    await LocalNotification.showPeriodicNot(
      title: 'Periodic Weather Update',
      body: 'Check the latest weather updates!',
      payload: 'periodic_weather_payload',
    );

    return Future.value(true);
  });
}