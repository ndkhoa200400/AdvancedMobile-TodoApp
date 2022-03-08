import 'package:flutter/material.dart';
import 'package:todo_app/common/search_bar.dart';
import 'package:todo_app/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                renderTitle(),
                // calendar and filter
                Row(
                  children: const [
                    Icon(
                      Icons.calendar_month,
                      color: AppColors.red,
                    ),
                    SizedBox(width: 8,),
                    Icon(
                      Icons.filter_list,
                      color: AppColors.red,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16,),
            SearchBar(searchController: _searchController)
          ],
        ),
      ),
    );
  }

  Widget renderTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const[
         Text('Today',
            style: TextStyle(color: AppColors.gray, fontSize: 14)),
        Text(
          'Monday, 07 March 2022',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        )
      ],
    );
  }
}
