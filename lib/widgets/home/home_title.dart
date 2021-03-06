import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';

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
          // calendar
          IconButton(
            onPressed: () => {Navigator.pushNamed(context, "/calendar-screen")},
            icon: const Icon(
              Icons.calendar_month,
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
