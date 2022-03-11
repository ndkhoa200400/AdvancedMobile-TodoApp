import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../constants/constants.dart';
import '../providers/todo_list_provider.dart';
import '../utils/filter.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String selectedFilter = "All";

  void applyFilter(String filter) {
    switch (filter) {
      case EnumFilter.all:
        Provider.of<TodoListProvider>(context, listen: false)
            .applyFilter(FilterAll());
        break;
      case EnumFilter.today:
        Provider.of<TodoListProvider>(context, listen: false)
            .applyFilter(FilterToday());
        break;
      case EnumFilter.upcoming:
        Provider.of<TodoListProvider>(context, listen: false)
            .applyFilter(FilterUpcoming());
        break;
      case EnumFilter.done:
        Provider.of<TodoListProvider>(context, listen: false)
            .applyFilter(FilterDone());
        break;
      default:
    }
  }

  void onTap(String result) {
    setState(() {
      selectedFilter = result;
    });
    applyFilter(result);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          selectedFilter,
          style: const TextStyle(
              color: AppColors.red, fontWeight: FontWeight.bold),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: PopupMenuButton<String>(
            icon: const Icon(
              Icons.filter_list,
              color: AppColors.red,
            ),
            tooltip: "Filter",
            onSelected: onTap,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: EnumFilter.all,
                child: Text(EnumFilter.all),
              ),
              const PopupMenuItem<String>(
                value: EnumFilter.today,
                child: Text(EnumFilter.today),
              ),
              const PopupMenuItem<String>(
                value: EnumFilter.upcoming,
                child: Text(EnumFilter.upcoming),
              ),
              const PopupMenuItem<String>(
                value: EnumFilter.done,
                child: Text(EnumFilter.done),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
