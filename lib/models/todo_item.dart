import 'package:intl/intl.dart';

DateFormat formattedDate = DateFormat('yyyy-MM-dd – HH:mm');
DateFormat formattedTime = DateFormat('HH:mm:ss');

class TodoItem {
  String id;
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;
  bool isDone = false;

  TodoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.isDone,
  });

  String getStartTime() {
    return formattedDate.format(startTime);
  }

  String getEndTime() {
    return formattedDate.format(endTime);
  }

  String getRangeTime() {
    return "${formattedTime.format(startTime)} - ${formattedTime.format(endTime)}";
  }
}
