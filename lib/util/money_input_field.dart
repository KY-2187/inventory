import 'package:flutter/material.dart';
import 'package:inventory/theme.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class MoneyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  const MoneyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: inputTitleStyle),
            Container(
                height: 52,
                margin: EdgeInsets.only(top: 8.0),
                padding: EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 1.0),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Expanded(
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MoneyInputFormatter(
                              leadingSymbol: "P")
                        ],
                        autofocus: false,
                        cursorColor: Colors.grey[600],
                        controller: controller,
                        style: subTitleStyle,
                        decoration: InputDecoration(
                            hintText: hint,
                            hintStyle: subTitleStyle,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 0)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 0)))),
                  ),
                ]))
          ],
        ));
  }
}
