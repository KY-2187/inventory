import 'package:flutter/material.dart';
import 'package:inventory/db/use.dart';
import 'package:inventory/theme.dart';

class UseTile extends StatelessWidget {
  final Use? use;
  UseTile(this.use);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
          width: MediaQuery.of(context).size.width - 35,
          height: 80,
          margin: EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200, spreadRadius: 5, blurRadius: 7)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        use?.date ?? "",
                        style: logStyle),
                      Row(
                        children: [
                          Text(
                            "Quantity Used: ",
                            style: logStyle),
                          Text(
                            use?.useQuantity.toString() ?? "",
                            style: logStyle)
                        ],)
                    ],
                  )
                ],
              ),
          )),
    );
  }
}
