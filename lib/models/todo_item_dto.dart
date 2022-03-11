import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

DateFormat formattedDate = DateFormat('yyyy-MM-dd – HH:mm');
DateFormat formattedTime = DateFormat('HH:mm:ss');

class TodoItemDTO {
  late String id;
  late String title;
  late String description;
  late DateTime startTime;
  late DateTime endTime;
  late bool isDone = false;

  TodoItemDTO({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.isDone,
  });

  TodoItemDTO.create({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.isDone = false,
  }) {
    id = uuid.v4();
  }

  TodoItemDTO.fromMap(Map<String, dynamic> item) {
    id = item['id'];
    title = item['title'];
    description = item['description'];
    startTime = DateTime.parse(item['starttime']);
    endTime = DateTime.parse(item['endtime']);
    isDone = item['isdone'] == 1 ? true : false;
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

  Map<String, dynamic> toMap() {
    Map<String, dynamic> m = {};
    m['id'] = id;
    m['title'] = title;
    m['isDone'] = isDone ? 1 : 0;
    m['description'] = description;
    m['startTime'] = startTime.toIso8601String();
    m['endTime'] = endTime.toIso8601String();

    return m;
  }
}
