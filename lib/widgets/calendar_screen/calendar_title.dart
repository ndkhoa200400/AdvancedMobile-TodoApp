import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';

class CalendarTitle extends StatelessWidget {
  const CalendarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderTitle(),
          // calendarr
          IconButton(
            onPressed: () => {Navigator.pushNamed(context, "/home")},
            icon: const Icon(
              Icons.home,
              color: AppColors.red,
              size: 24,
            ),
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
