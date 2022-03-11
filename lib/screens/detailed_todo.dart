import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/style.dart';
import 'package:todo_app/models/todo_item_dto.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/widgets/home/todo_list.dart';

class DetailedTodoScreen extends StatelessWidget {
  final TodoItemDTO todoItemDTO;
  const DetailedTodoScreen({Key? key, required this.todoItemDTO})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.white,
          foregroundColor: Colors.black,
        ),
        body: Consumer<TodoListProvider>(
          builder: ((context, value, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          todoItemDTO.title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        // Status
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                  color: todoItemDTO.isDone
                                      ? AppColors.lightgreen
                                      : AppColors.pink,
                                  shape: BoxShape.circle),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(todoItemDTO.isDone ? "Done" : "In progress")
                          ],
                        ),
                        // Time
                        const SizedBox(height: 16),
                        _renderRangeTime(),

                        // Description
                        const SizedBox(
                          height: 16,
                        ),
                        Text(todoItemDTO.description)
                      ],
                    ),
                  ),
                  _renderButton(context)
                ],
              )),
        ));
  }

  Widget _renderButton(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: ElevatedButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
          backgroundColor: AppColors.pink,
          elevation: 2,
        ),
        onPressed: () {
          Provider.of<TodoListProvider>(ctx, listen: false)
              .handleCheckbox(todoItemDTO.id, !todoItemDTO.isDone);
        },
        child: Center(
          child: Text(todoItemDTO.isDone ? "Undo it" : 'Done it',
              style: const TextStyle(color: AppColors.white)),
        ),
      ),
    );
  }

  Widget _renderRangeTime() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // _renderTime(widget.todoItem.getStartTime()),
        Row(
          children: [
            const SizedBox(width: 48, child: Text("From")),
            Text(todoItemDTO.getStartTime())
          ],
        ),

        const SizedBox(
          height: 4,
        ),

        Row(
          children: [
            const SizedBox(width: 48, child: Text("To")),
            Text(todoItemDTO.getEndTime())
          ],
        ),

        // _renderTime(widget.todoItem.getEndTime())
      ],
    );
  }
}
