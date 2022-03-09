import 'package:flutter/material.dart';
import 'package:todo_app/utils/show_toast.dart';

import '../constants/app_colors.dart';
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
      print("okl");
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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
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
                const Text(
                  'Add new TODO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
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
      ),
      Positioned(
          right: 16,
          child: TextButton(
            style: TextButton.styleFrom(
                primary: AppColors.pink,
                textStyle: TextStyle(color: AppColors.pink)),
            child: const Text(
              "Done",
            ),
            onPressed: onDone,
          )),
    ]);
  }
}
