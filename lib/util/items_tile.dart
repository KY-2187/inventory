import 'package:flutter/material.dart';
import 'package:inventory/db/item.dart';
import 'package:inventory/theme.dart';

class ItemsTile extends StatelessWidget {
  final Item? item;
  ItemsTile(this.item);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
          width: MediaQuery.of(context).size.width - 35,
          height: 70,
          margin: EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200, spreadRadius: 5, blurRadius: 7)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Flexible(
                child: Text(item?.itemName ?? "",
                    style: titleStyle.copyWith(fontSize: 16),
                    overflow: TextOverflow.ellipsis,),
              ),
              Text(item?.quantity.toString() ?? "",
                  style: titleStyle.copyWith(fontSize: 25, color: Colors.grey))
            ]),
          )),
    );
  }
}
