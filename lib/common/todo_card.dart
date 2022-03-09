import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/style.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/widgets/home/custom_checkbox.dart';

class TodoCard extends StatefulWidget {
  final TodoItem todoItem;
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
    return Container(
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
                  onCheckboxChanged: onCheckboxChange)
            ]),
      ),
    );
  }

  Widget _renderTime(String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const Icon(
        //   Icons.access_time,
        //   size: 16,
        // ),
        // const SizedBox(
        //   width: 8,
        // ),
        Text(time)
      ],
    );
  }

  Widget _renderRangeTime() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // _renderTime(widget.todoItem.getStartTime()),
        Text("Start time: ${widget.todoItem.getStartTime()}"),
        const SizedBox(
          height: 4,
        ),

        Text("End time: ${widget.todoItem.getEndTime()}"),

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
