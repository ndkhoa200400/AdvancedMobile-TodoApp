import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/style.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final Color? fillColor;
  final TextEditingController textEditingController;
  final bool expands;
  final int? minLines;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextInputType textInputType;
  final String errorText;
  const CustomInputField(
      {Key? key,
      this.hintText,
      this.fillColor,
      required this.textEditingController,
      this.errorText = "",
      this.maxLines = 1,
      this.minLines = 1,
      this.textInputAction,
      this.textInputType = TextInputType.text,
      this.expands = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        expands: expands,
        maxLines: maxLines,
        minLines: minLines,
        textInputAction: textInputAction,
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.top,
        controller: textEditingController,
        keyboardType: textInputType,
        textCapitalization: TextCapitalization.sentences,
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
