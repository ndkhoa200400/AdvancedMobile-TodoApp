import 'package:todo_app/models/todo_item_dto.dart';

abstract class NotificationService {
  void init(
      Future<dynamic> Function(int, String?, String?, String?)? onDidReceive);
  Future selectNotification(String? payload);
  void showNotification(TodoItemDTO todoItemDTO, String notificationMessage);
  void scheduleNotificationForDeadline(
      TodoItemDTO todoItemDTO, String notificationMessage);
}
