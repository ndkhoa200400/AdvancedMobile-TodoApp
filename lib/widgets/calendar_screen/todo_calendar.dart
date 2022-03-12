import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/models/todo_item_dto.dart';

class TodoCalendar extends StatelessWidget {
  final List<TodoItemDTO> Function(DateTime) getEventsForDay;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  const TodoCalendar(
      {required this.getEventsForDay,
      required this.onDaySelected,
      required this.focusedDay,
      required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TableCalendar<TodoItemDTO>(
        eventLoader: getEventsForDay,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.now().add(const Duration(days: 365 * 10 * 3)),
        focusedDay: focusedDay,
        calendarFormat: CalendarFormat.month,
        selectedDayPredicate: (day) {
          return isSameDay(selectedDay, day);
        },
        calendarStyle: const CalendarStyle(
            // Use `CalendarStyle` to customize the UI
            outsideDaysVisible: false,
            selectedDecoration:
                BoxDecoration(shape: BoxShape.circle, color: AppColors.pink),
            todayDecoration:
                BoxDecoration(shape: BoxShape.circle, color: AppColors.coral)),
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: onDaySelected,
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          focusedDay = focusedDay;
        },
      ),
    );
  }
}
