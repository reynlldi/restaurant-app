import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/list_restaurant_model.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings("app_icon");

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) async {
      final payload = details.payload;
      if (payload != null) {
        print("notification payload: " + payload);
      }
      selectNotificationSubject.add(payload ?? "empty payload");
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ListRestaurantResult restaurants) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "restaurant channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    var titleNotification = "<b>Recommendation Best Restaurant For You!</b>";
    final randomRestaurant = Random().nextInt(restaurants.restaurants.length);
    final restaurant = restaurants.restaurants[randomRestaurant];

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      restaurant.name,
      platformChannelSpecifics,
      payload: json.encode(
        restaurant.toJson(),
      ),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((payload) async {
      final data = ListRestaurant.fromJson(json.decode(payload));
      Navigation.intentWithData(route, data);
    });
  }
}
