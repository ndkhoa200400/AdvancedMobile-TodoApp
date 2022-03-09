import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';

class EnumFilter {
  static const String all = "All";
  static const String incoming = "Incoming";
  static const String done = "Done";
}

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
                        print('filter 1 clicked');
                        break;
                      case EnumFilter.incoming:
                        print('filter 2 clicked');
                        break;
                      case EnumFilter.done:
                        print('Clear filters');
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
                      value: EnumFilter.incoming,
                      child: Text(EnumFilter.incoming),
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
