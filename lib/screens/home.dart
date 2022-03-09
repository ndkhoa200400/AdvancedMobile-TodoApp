import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/add_new_todo.dart';
import 'package:todo_app/common/custom_floating_action_button.dart';
import 'package:todo_app/common/search_bar.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/widgets/home/home_title.dart';
import 'package:todo_app/widgets/home/todo_list.dart';

import '../models/todo_item.dart';

// List<TodoItem> todoList = [
//   TodoItem(
//       id: "1",
//       title: "House Cleaning",
//       description: "Quét dọn nhà",
//       startTime: DateTime(2022),
//       endTime: DateTime(2022),
//       isDone: false),
//   TodoItem(
//       id: "2",
//       title: "House Cleaning",
//       description: "Quét dọn nhà",
//       startTime: DateTime(2022),
//       endTime: DateTime(2022),
//       isDone: false),
//   TodoItem(
//       id: "3",
//       title: "House Cleaning",
//       description: "Quét dọn nhà",
//       startTime: DateTime(2022),
//       endTime: DateTime(2022),
//       isDone: true),
// ];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<List<TodoItem>>(
        builder: ((context, todoList, child) => Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Column(
                children: [
                  // title
                  const HomeTitle(),

                  SearchBar(searchController: _searchController),

                  TodoList(todoList: todoList)
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: CustomFloatingActionButton(
              onPressed: showAddNewTodoBottomModal,
            ))));
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
