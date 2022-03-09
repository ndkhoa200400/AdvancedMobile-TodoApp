import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final Function(bool? value) onCheckboxChanged;
  const CustomCheckBox(
      {Key? key, required this.isChecked, required this.onCheckboxChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (!isChecked) {
        return AppColors.pink;
      }
      return AppColors.lightgreen;
    }

    Color getSideColor() {
      if (!isChecked) {
        return AppColors.pink;
      }
      return AppColors.lightgreen;
    }

    return Transform.scale(
      scale: 1.5,
      child: Checkbox(
        side: BorderSide(color: getSideColor(), width: 0.7),
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: onCheckboxChanged,
      ),
    );
  }
}
