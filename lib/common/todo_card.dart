import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/style.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo_item_dto.dart';
import 'package:todo_app/screens/detailed_todo.dart';
import 'package:todo_app/widgets/home/custom_checkbox.dart';

import '../providers/todo_list_provider.dart';

class TodoCard extends StatefulWidget {
  final TodoItemDTO todoItem;
  const TodoCard({required this.todoItem});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  void onCheckboxChange(bool? value) {
    setState(() {
      widget.todoItem.isDone = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    DetailedTodoScreen(todoItemDTO: widget.todoItem))));
      },
      child: Container(
        // height: 85,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: AppColors.gray,
                blurRadius: 1,
                offset: Offset(0, 0), // changes position of shadow
              )
            ],
            border: Border.all(color: AppColors.gray, width: 0.2),
            borderRadius: BorderRadius.circular(borderRadius),
            color: AppColors.white),
        child: IntrinsicHeight(
          child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height,
                      width: 24,
                      decoration: BoxDecoration(
                          color: getCardColor(),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(borderRadius),
                              bottomLeft: Radius.circular(borderRadius))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.todoItem.title,
                            style: TextStyle(
                                color: getTextColor(),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(widget.todoItem.description),
                          const SizedBox(
                            height: 8,
                          ),
                          _renderRangeTime()
                        ],
                      ),
                    ),
                  ],
                ),
                CustomCheckBox(
                    isChecked: widget.todoItem.isDone,
                    onCheckboxChanged: (bool? value) {
                      Provider.of<TodoListProvider>(context, listen: false)
                          .handleCheckbox(widget.todoItem.id, value!);
                    })
              ]),
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
            Text(widget.todoItem.getStartTime())
          ],
        ),

        const SizedBox(
          height: 4,
        ),

        Row(
          children: [
            const SizedBox(width: 48, child: Text("To")),
            Text(widget.todoItem.getEndTime())
          ],
        ),

        // _renderTime(widget.todoItem.getEndTime())
      ],
    );
  }

  Color getTextColor() {
    if (widget.todoItem.isDone) {
      return AppColors.darkgreen;
    } else {
      return AppColors.red;
    }
  }

  Color getCardColor() {
    if (widget.todoItem.isDone) {
      return AppColors.lightgreen;
    } else {
      return AppColors.pink;
    }
  }
}
