import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/screens/detailed_todo.dart';
import 'package:todo_app/service/navigation_service.dart';
import 'package:todo_app/service/service_locator.dart';

import '../constants/constants.dart';
import '../models/todo_item_dto.dart';
import 'notification_service.dart';

const String channelId = "662";

class NotificationServiceImpl extends NotificationService {
  NotificationServiceImpl() {
    init(null);
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void init(
      Future<dynamic> Function(int, String?, String?, String?)? onDidReceive) {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceive);

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    initializeLocalNotificationsPlugin(initializationSettings);

    tz.initializeTimeZones();
  }

  void initializeLocalNotificationsPlugin(
      InitializationSettings initializationSettings) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  @override
  Future selectNotification(String? payload) async {
    TodoItemDTO todoItemDTO = getTodoItemFromPayload(payload ?? '');
    cancelNotificationForTodoItem(todoItemDTO);

    getIt<NavigationService>().navigateTo("/detailed-todo", todoItemDTO.id);
  }

  void cancelNotificationForTodoItem(TodoItemDTO todoItemDTO) async {
    await flutterLocalNotificationsPlugin.cancel(todoItemDTO.hashCode);
  }

  @override
  void showNotification(
      TodoItemDTO todoItemDTO, String notificationMessage) async {
    await flutterLocalNotificationsPlugin.show(
        todoItemDTO.hashCode,
        applicationName,
        notificationMessage,
        NotificationDetails(
            android: AndroidNotificationDetails(channelId, applicationName,
                importance: Importance.max,
                priority: Priority.high,
                channelDescription: 'To remind you about upcoming deadline.')),
        payload: jsonEncode(todoItemDTO));
  }

  TodoItemDTO getTodoItemFromPayload(String payload) {
    Map<String, dynamic> json = jsonDecode(payload);
    TodoItemDTO todoItemDTO = TodoItemDTO.fromMap(json);
    return todoItemDTO;
  }

  @override
  void scheduleNotificationForDeadline(
      TodoItemDTO todoItemDTO, String notificationMessage) async {
    DateTime now = DateTime.now();
    DateTime deadlineDate = todoItemDTO.endTime;

    DateTime timeToNotify = now.add(notificationTime).isAfter(deadlineDate)
        ? now
        : deadlineDate.subtract(notificationTime);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        todoItemDTO.hashCode,
        applicationName,
        notificationMessage,
        tz.TZDateTime.from(timeToNotify, tz.getLocation("Asia/Bangkok"))
            .add(const Duration(seconds: 1)),
        NotificationDetails(
            android: AndroidNotificationDetails(channelId, applicationName,
                importance: Importance.max,
                priority: Priority.high,
                channelDescription: 'To remind you about upcoming deadline')),
        payload: jsonEncode(todoItemDTO),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
