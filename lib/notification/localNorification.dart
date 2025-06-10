import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onClick = BehaviorSubject<String>();

  //on notification click
  static void onNotificationClick(NotificationResponse response) {
    onClick.add(response.payload!);
  }

  //initilize the notification
  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) => onNotificationClick,
      onDidReceiveBackgroundNotificationResponse:onNotificationClick,
    );
  }

  //simple notification
  static Future showSimpleNot(
      {required String title,
      required String body,
      required String payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'simple channel id', 'simple channel name',
      channelDescription: 'simple channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      //showWhen: false
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  //periodic notification

  static Future showPeriodicNot(
      {required String title,
      required String body,
      required String payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel 2', 'simple channel name',
      channelDescription: 'simple channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      //showWhen: false
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      title,
      body,
      RepeatInterval.hourly,
      platformChannelSpecifics,
    );
  }

  //close spacific channel notification
  static Future cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  //close all notification
  static Future cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  //schedule notification
  static Future showScheduleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'channel 3', 'your channel name',
                channelDescription: 'your channel description',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
  }
}
