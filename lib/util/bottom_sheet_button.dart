import 'package:flutter/material.dart';
import 'package:inventory/theme.dart';

class BottomSheetButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final Color buttonColor;
  final Color labelColor;
  final BuildContext context;
  const BottomSheetButton({Key? key,
    required this.label,
    required this.onTap,
    required this.buttonColor,
    required this.labelColor,
    required this.context
  })
   : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 55,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: buttonColor,
            ),
            child: Center(
              child: Text(label,
                  style: subTitleStyle.copyWith(color: labelColor)),
            )));
  }
}