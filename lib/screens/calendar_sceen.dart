import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:todo_app/common/add_new_todo.dart';
import 'package:todo_app/common/custom_floating_action_button.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/models/todo_item_dto.dart';
import 'package:todo_app/widgets/calendar_screen/todo_calendar.dart';
import 'package:todo_app/widgets/home/todo_list.dart';

import '../common/filter_section.dart';
import '../providers/todo_list_provider.dart';
import '../widgets/calendar_screen/calendar_title.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay = _focusedDay;
  late final ValueNotifier<List<TodoItemDTO>> _selectedEvents;

  @override
  void initState() {
    super.initState();

    Provider.of<TodoListProvider>(context, listen: false).loadStorage();
  }

  List<TodoItemDTO> _getEventsForDay(DateTime day) {
    // Implementation example
    return context
        .watch<TodoListProvider>()
        .todoList
        .where((element) => isSameDay(element.endTime, day))
        .toList();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      // _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // title
              const CalendarTitle(),
              TodoCalendar(
                  getEventsForDay: _getEventsForDay,
                  onDaySelected: _onDaySelected,
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay),
              const FilterSection(),
              Consumer<TodoListProvider>(
                builder: ((context, value, child) =>
                    TodoList(todoList: _getEventsForDay(_selectedDay))),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomFloatingActionButton(
          onPressed: showAddNewTodoBottomModal,
        ));
  }

  void showAddNewTodoBottomModal() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return const BottomSheetAddNewTodo();
      },
    );
  }
}
