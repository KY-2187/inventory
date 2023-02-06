import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/db/item.dart';
import 'package:inventory/db/item_controller.dart';
import 'package:inventory/pages/home_page.dart';
import 'package:inventory/pages/item_page.dart';
import 'package:inventory/pages/search_page.dart';
import 'package:inventory/pages/settings_page.dart';
import 'package:inventory/theme.dart';
import 'package:inventory/util/bottom_sheet_button.dart';
import 'package:inventory/util/items_tile.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final _itemController = Get.put(ItemController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: grey,
        appBar: _appBar(),
        bottomNavigationBar: _bottomBar(),
        body: Container(
          margin: EdgeInsets.only(left:10, right: 10),
          child: Column(children: [SizedBox(height: 20), _showItems()]),
        ));
  }

  _showItems() {
    _itemController.getItems();
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _itemController.itemList.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onLongPress: () {_showBottomSheet(context, _itemController.itemList[index]);},
                onTap: () {
                  Get.to(
                    () => ItemPage(_itemController.itemList[index]), 
                    duration: Duration(milliseconds: 0));
                },
                child: ItemsTile(_itemController.itemList[index]));
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Item item) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top: 4),
          height: MediaQuery.of(context).size.height * 0.22,
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
              "Do you want to delete",
              style: inputTitleStyle.copyWith(fontSize: 16)
              ),
              Text(
                "${item.itemName} ?",
                style: inputTitleStyle.copyWith(fontSize: 16)),
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
                    label: "Delete Item",
                    onTap: () {
                      _itemController.delete(item);
                      Get.back();
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
            automaticallyImplyLeading: false,
            centerTitle: true,
            toolbarHeight: 100,
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: Text("Inventory", style: titleStyle),
          )),
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
