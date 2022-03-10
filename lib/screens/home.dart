import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/add_new_todo.dart';
import 'package:todo_app/common/custom_floating_action_button.dart';
import 'package:todo_app/common/search_bar.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/widgets/home/home_title.dart';
import 'package:todo_app/widgets/home/todo_list.dart';

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
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // title
              const HomeTitle(),

              SearchBar(searchController: _searchController),
              Consumer<TodoListProvider>(
                builder: ((context, value, child) =>
                    TodoList(todoList: value.todoList)),
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
