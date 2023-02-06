// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:inventory/pages/buy_page.dart';
import 'package:inventory/pages/inventory_page.dart';
import 'package:inventory/pages/new_item_page.dart';
import 'package:inventory/pages/search_page.dart';
import 'package:inventory/pages/settings_page.dart';
import 'package:inventory/pages/use_page.dart';
import 'package:inventory/theme.dart';
import 'package:inventory/util/menu_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: _appBar(),
      bottomNavigationBar: _bottomBar(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuButton(
                  iconImage: CupertinoIcons.cube_box,
                  buttonText: 'Inventory',
                  onTap: () {
                    Get.to(() => InventoryPage(),
                        duration: Duration(milliseconds: 0));
                  }),
              MenuButton(
                  iconImage: CupertinoIcons.add_circled,
                  buttonText: 'New Item',
                  onTap: () {
                    Get.to(() => NewItemPage(),
                        duration: const Duration(milliseconds: 0));
                  }),
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuButton(
                  iconImage: CupertinoIcons.shopping_cart,
                  buttonText: 'Buy',
                  onTap: () {
                    Get.to(() => BuyPage(),
                        duration: const Duration(milliseconds: 0));
                  }),
              MenuButton(
                  iconImage: CupertinoIcons.bolt,
                  buttonText: 'Use',
                  onTap: () {
                    Get.to(() => UsePage(),
                        duration: const Duration(milliseconds: 0));
                  })
            ],
          )
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
                onPressed: () {},
                icon: Icon(CupertinoIcons.home, size: 28, color: purple)),
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
