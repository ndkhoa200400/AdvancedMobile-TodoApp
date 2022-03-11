import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/utils/filter.dart';

import '../../constants/app_colors.dart';
import '../../constants/constants.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderTitle(),
          // calendar and filter
          Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: AppColors.red,
              ),
              const SizedBox(
                width: 8,
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
                  onSelected: (String result) {
                    switch (result) {
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
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
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
          )
        ],
      ),
    );
  }

  Widget renderTitle() {
    DateFormat formattedDate = DateFormat.yMMMMEEEEd();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Today',
            style: TextStyle(color: AppColors.gray, fontSize: 16)),
        const SizedBox(
          height: 4,
        ),
        Text(
          formattedDate.format(DateTime.now()),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )
      ],
    );
  }
}
