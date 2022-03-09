import 'package:intl/intl.dart';

DateFormat formattedDate = DateFormat('yyyy-MM-dd – HH:mm');

String formateDate(DateTime date) {
  return formattedDate.format(date);
}
