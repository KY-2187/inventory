import 'package:flutter/material.dart';
import 'package:inventory/theme.dart';

class SubmitButton extends StatelessWidget {
  final String buttonLabel;
  final Function()? onTap;
  const SubmitButton({Key? key, required this.buttonLabel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 55,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: purple,
            ),
            child: Center(
              child: Text(buttonLabel,
                  style: inputTitleStyle.copyWith(color: Colors.white)),
            )));
  }
}
