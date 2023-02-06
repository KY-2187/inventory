import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory/db/item_controller.dart';
import 'package:inventory/pages/home_page.dart';
import 'package:inventory/pages/item_page.dart';
import 'package:inventory/pages/settings_page.dart';
import 'package:inventory/theme.dart';
import 'package:inventory/util/input_field.dart';
import 'package:inventory/util/items_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _itemController = Get.put(ItemController());
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(_showItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      bottomNavigationBar: _bottomBar(),
      body: Padding(
        padding: const EdgeInsets.only(left:15, right: 15),
        child: Column(
          children: [
            SizedBox(height: 40),
            MyInputField(
              title: "Search", 
              hint: "Search item...",
              controller: _searchTextController),
            _showItems()
          ]
        ),
      ),
    );
  }

  _showItems() {
    _itemController.getSearchedItems(_searchTextController.text);
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _itemController.itemList.length,
            itemBuilder: (_, index) {
              return GestureDetector(
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
                onPressed: () {},
                icon: Icon(CupertinoIcons.search,
                    size: 28, color: purple)),
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