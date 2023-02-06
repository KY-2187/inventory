import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/db/buy.dart';
import 'package:inventory/db/buy_controller.dart';
import 'package:inventory/db/item.dart';
import 'package:inventory/db/item_controller.dart';
import 'package:inventory/db/use.dart';
import 'package:inventory/db/use_controller.dart';
import 'package:inventory/pages/home_page.dart';
import 'package:inventory/pages/search_page.dart';
import 'package:inventory/pages/settings_page.dart';
import 'package:inventory/theme.dart';
import 'package:inventory/util/bottom_sheet_button.dart';
import 'package:inventory/util/buy_tile.dart';
import 'package:inventory/util/items_tile.dart';
import 'package:inventory/util/use_tile.dart';

class ItemPage extends StatefulWidget {
  final Item? item;
  ItemPage(this.item);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final _itemController = Get.put(ItemController());
  final _buyController = Get.put(BuyController());
  final _useController = Get.put(UseController());
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: grey,
        appBar: _appBar(),
        bottomNavigationBar: _bottomBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey.shade200, 
                    blurRadius: 10.0, 
                    spreadRadius: 5)]
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TabBar(
                    labelStyle: TextStyle(fontSize: 18),
                    unselectedLabelColor: purple,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: purple),
                    tabs:[
                      Tab(text: "Buy"),
                      Tab(text: "Use")
                  ]),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _showBuy(),
                    _showUse()
                  ]),
              )
            ],))
      ),
    );
  }

  _showBuy() {
    _buyController.getBuy(widget.item?.itemName ?? "");
    return Column(
      children: [
        SizedBox(height: 15),
        Expanded(
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _buyController.buyList.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onLongPress: () {
                      _showBottomSheet(
                        context, 
                        _buyController.buyList[index],
                        true);
                    },
                    child: BuyTile(_buyController.buyList[index]));
                });
          }),
        ),
      ],
    );
  }

  _showUse() {
    _useController.getUse(widget.item?.itemName ?? "");
    return Column(
      children: [
        SizedBox(height: 15),
        Expanded(
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _useController.useList.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onLongPress: () {
                      _showBottomSheet(context, _useController.useList[index], false);
                    },
                    child: UseTile(_useController.useList[index]));
                });
          }),
        ),
      ],
    );
  }

  _showBottomSheet(BuildContext context, var type, bool isBuy) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top: 4),
          height: MediaQuery.of(context).size.height * 0.18,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300])),
              SizedBox(height: 20),
              Text(
                "Do you want to delete this?",
                style: inputTitleStyle.copyWith(fontSize: 16)
                ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   BottomSheetButton(
                    label: "Close",
                    onTap: () {
                      Get.back();
                    },
                    buttonColor: Colors.grey.shade200,
                    labelColor: Colors.black,
                    context: context),
                  BottomSheetButton(
                    label: "Delete",
                    onTap: () {
                      if (isBuy == true)
                      {
                        _buyController.delete(type, widget.item?.itemName ?? "");
                        Get.back();
                      }
                      else
                      {
                        _useController.delete(type, widget.item?.itemName ?? "");
                        Get.back();
                      }
                    },
                    buttonColor: red,
                    labelColor: Colors.white,
                    context: context)
                ]
              ),
              SizedBox(height: 10)
            ],
          )),
    );
  }

  _appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, blurRadius: 10.0, spreadRadius: 5)
          ]),
          child: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(CupertinoIcons.back, color: Colors.grey[400], size: 35,)),
            toolbarHeight: 100,
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.item?.itemName ?? "", 
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle.copyWith(fontSize: 24)),
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.item?.quantity.toString() ?? "", 
                    style: titleStyle.copyWith(color: Colors.grey))
                ],
              ),
            )
        ),
      )
    );
  }

  _bottomBar() {
    return BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  Get.to(() => HomePage(), duration: Duration(milliseconds: 0));
                },
                icon: Icon(CupertinoIcons.home,
                    size: 28, color: Colors.grey[300])),
            IconButton(
                onPressed: () {
                  Get.to(() => SearchPage(), duration: Duration(milliseconds: 0));
                },
                icon: Icon(CupertinoIcons.search,
                    size: 28, color: Colors.grey[300])),
            IconButton(
                onPressed: () {
                  Get.to(() => SettingsPage(), duration: Duration(milliseconds: 0));
                },
                icon: Icon(CupertinoIcons.settings,
                    size: 28, color: Colors.grey[300]))
          ],
        ));
  }
}
