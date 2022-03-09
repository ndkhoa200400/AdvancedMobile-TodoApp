import 'package:flutter/material.dart';
import 'package:todo_app/constants/style.dart';

import '../constants/app_colors.dart';
import 'custom_input_field.dart';

class BottomSheetAddNewTodo extends StatefulWidget {
  const BottomSheetAddNewTodo({Key? key}) : super(key: key);

  @override
  State<BottomSheetAddNewTodo> createState() => _BottomSheetAddNewTodoState();
}

class _BottomSheetAddNewTodoState extends State<BottomSheetAddNewTodo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 5,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
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
            ),
            const SizedBox(height: 16),
            CustomInputField(
              hintText: "Start time",
              fillColor: AppColors.inputFieldColor,
              textInputType: TextInputType.datetime,
              textEditingController: _startTimeController,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              hintText: "End time",
              fillColor: AppColors.inputFieldColor,
              textInputType: TextInputType.datetime,
              textEditingController: _endTimeController,
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
    );
  }
}
