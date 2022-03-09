import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/style.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomFloatingActionButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      disabledElevation: 0,
      elevation: 0,
      onPressed: onPressed,
      // backgroundColor: AppColors.pink,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.pink,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: const [
            BoxShadow(
              color: AppColors.coral,
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
            )
          ],
        ),
        alignment: Alignment.center,
        // padding: const EdgeInsets.all(4),
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      // ...FloatingActionButton properties...
    );
  }
}
