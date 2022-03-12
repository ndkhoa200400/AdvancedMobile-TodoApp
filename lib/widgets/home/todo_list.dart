import 'package:flutter/material.dart';
import 'package:todo_app/common/todo_card.dart';
import 'package:todo_app/models/todo_item_dto.dart';

class TodoList extends StatelessWidget {
  final List<TodoItemDTO> todoList;
  const TodoList({Key? key, required this.todoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: TodoCard(todoItem: todoList[index]));
        },
      ),
    ));
  }
}
