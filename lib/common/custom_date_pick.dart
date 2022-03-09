import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app/utils/date_formatter.dart';

import '../constants/app_colors.dart';
import '../constants/style.dart';

class CustomDatePick extends StatelessWidget {
  final String? hintText;
  final Color? fillColor;
  final Function(DateTime date) setDate;
  final bool expands;
  final int? minLines;
  final int? maxLines;
  final TextInputAction? textInputAction;

  final currentTime;
  TextEditingController editingController = TextEditingController();

  final String errorText;
  CustomDatePick(
      {Key? key,
      required this.setDate,
      required this.currentTime,
      this.errorText = "",
      this.hintText,
      this.fillColor,
      this.maxLines = 1,
      this.minLines = 1,
      this.textInputAction,
      this.expands = false})
      : super(key: key) {
    editingController.text = formateDate(currentTime);
  }

  void _selectDate(BuildContext context) async {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      theme: const DatePickerTheme(
          itemStyle: TextStyle(color: Colors.black),
          doneStyle: TextStyle(color: AppColors.pink)),
      minTime: DateTime(2018, 3, 5),
      maxTime: DateTime(2019, 6, 7),
      onChanged: (date) {
        editingController.text = formateDate(date);
      },
      onConfirm: setDate,
      currentTime: currentTime,
      locale: LocaleType.en,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        expands: expands,
        maxLines: maxLines,
        minLines: minLines,
        onTap: () => _selectDate(context),
        textInputAction: textInputAction,
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.top,
        // controller: textEditingController,
        controller: editingController,
        keyboardType: TextInputType.none,
        decoration: InputDecoration(
            errorText: errorText.isEmpty ? null : errorText,
            contentPadding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            filled: true,
            fillColor: fillColor,
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.gray)));
  }
}
