import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data-access/todo-dao.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/utils/show_toast.dart';
import 'package:todo_app/widgets/home/todo_list.dart';

import '../constants/app_colors.dart';
import '../providers/todo_list_provider.dart';
import 'custom_date_pick.dart';
import 'custom_input_field.dart';

class BottomSheetAddNewTodo extends StatefulWidget {
  const BottomSheetAddNewTodo({Key? key}) : super(key: key);

  @override
  State<BottomSheetAddNewTodo> createState() => _BottomSheetAddNewTodoState();
}

class _BottomSheetAddNewTodoState extends State<BottomSheetAddNewTodo> {
  final TextEditingController _titleController = TextEditingController();
  DateTime _startTime = DateTime.now(), _endTime = DateTime.now();
  final TextEditingController _descriptionController = TextEditingController();

  String titleErrorText = "";
  String startTimeErrorText = "";
  String endTimeErrorText = "";

  void resetError() {
    setState(() {
      titleErrorText = "";
      startTimeErrorText = "";
      endTimeErrorText = "";
    });
  }

  void onDone() {
    resetError();
    bool isError = false;
    if (_startTime.isAfter(_endTime)) {
      setState(() {
        startTimeErrorText = "Start time must be before end time.";
        endTimeErrorText = "Start time must be before end time.";
      });
      isError = true;
    }

    if (_titleController.text.isEmpty) {
      setState(() {
        titleErrorText = "Title must be filled";
      });
      isError = true;
    }

    if (isError) {
      return;
    }

    Navigator.pop(context);
    showToast(context, "Added new Todo");
    TodoItem todoItem = TodoItem.create(
        title: _titleController.text,
        description: _descriptionController.text,
        startTime: _startTime,
        endTime: _endTime);
    try {
      final TodoListDAO todoDAO = TodoListDAO();

      Provider.of<TodoListProvider>(context, listen: false)
          .addNewTodo(todoItem);
    } catch (error) {
      showToast(context, "Insert got error $error. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * 3 / 5,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 56,
                child: Stack(
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    alignment: Alignment.topCenter,
                    children: [
                      const Align(
                        child: Text(
                          'Add new TODO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              primary: AppColors.pink,
                              textStyle: const TextStyle(
                                  color: AppColors.pink, fontSize: 16)),
                          child: const Text(
                            "Done",
                          ),
                          onPressed: onDone,
                        ),
                      )
                    ]),
              ),
              // const SizedBox(height: 32),
              CustomInputField(
                hintText: "Title",
                fillColor: AppColors.inputFieldColor,
                textEditingController: _titleController,
                errorText: titleErrorText,
              ),
              const SizedBox(height: 16),
              CustomDatePick(
                hintText: "Start time",
                currentTime: _startTime,
                fillColor: AppColors.inputFieldColor,
                errorText: startTimeErrorText,
                setDate: (DateTime date) {
                  setState(() {
                    _startTime = date;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomDatePick(
                hintText: "End time",
                currentTime: _endTime,
                fillColor: AppColors.inputFieldColor,
                errorText: endTimeErrorText,
                setDate: (DateTime date) {
                  setState(() {
                    _endTime = date;
                  });
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: CustomInputField(
                  hintText: "Description",
                  fillColor: AppColors.inputFieldColor,
                  textEditingController: _descriptionController,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
