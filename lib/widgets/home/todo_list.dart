import 'package:flutter/material.dart';
import 'package:todo_app/common/todo_card.dart';
import 'package:todo_app/models/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoItem> todoList;
  const TodoList({Key? key, required this.todoList}) : super(key: key);

  void sortListByDone() {
    todoList.sort((a, b) => a.isDone ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    sortListByDone();
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
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
