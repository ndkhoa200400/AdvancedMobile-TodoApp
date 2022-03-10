import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

DateFormat formattedDate = DateFormat('yyyy-MM-dd – HH:mm');
DateFormat formattedTime = DateFormat('HH:mm:ss');

class TodoItem {
  late String id;
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

  TodoItem.create({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.isDone = false,
  }) {
    id = uuid.v4();
  }

  String getStartTime() {
    return formattedDate.format(startTime);
  }

  String getEndTime() {
    return formattedDate.format(endTime);
  }

  String getRangeTime() {
    return "${formattedTime.format(startTime)} - ${formattedTime.format(endTime)}";
  }

   toJSONEncodable() {
    Map<String, dynamic> m = {};

    m['title'] = title;
    m['isDone'] = isDone;
    m['description'] = description;
    m['startTime'] = startTime.toIso8601String();
    m['endTime'] = endTime.toIso8601String();

    return m;
  }

}
