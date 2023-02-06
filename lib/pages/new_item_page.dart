import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory/db/db_helper.dart';
import 'package:inventory/db/item.dart';
import 'package:inventory/db/item_controller.dart';
import 'package:inventory/pages/home_page.dart';
import 'package:inventory/pages/inventory_page.dart';
import 'package:inventory/pages/search_page.dart';
import 'package:inventory/pages/settings_page.dart';
import 'package:inventory/theme.dart';
import 'package:inventory/util/input_field.dart';
import 'package:inventory/util/money_input_field.dart';
import 'package:inventory/util/submit_button.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({Key? key}) : super(key: key);

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final ItemController _itemController = Get.put(ItemController());
  final TextEditingController _itemNameController = TextEditingController();
  late Future<List> futureItemsList = _itemController.getDistinctItems();
  List<String> itemsList = [];
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    _convertFutureListToList();
    return Scaffold(
        backgroundColor: grey,
        appBar: _appBar(),
        bottomNavigationBar: _bottomBar(),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyInputField(
                  title: "Item Name",
                  hint: "Enter item name",
                  controller: _itemNameController,
                ),
                SizedBox(height: 16),
                SubmitButton(
                    buttonLabel: "Add Item", onTap: () => _validateForm())
              ],
            ),
          ),
        ));
  }

  int counter = 0;
  void _convertFutureListToList() async {
    List list = await futureItemsList;
    if (counter == 0)
    {
      list.forEach((element) {
        setState(() {
          itemsList.add(element['itemName']);
        });
      });
      counter++;
    }
  }

  bool _itemExists(String itemName)
  {
    bool existing = false;
    for (int i = 0; i < itemsList.length; i++)
    {
      if (itemsList[i] == itemName)
      {
        existing = true;
        return existing;
      }
    }
    return existing;
  }

  _validateForm() {
    if (_itemNameController.text.isNotEmpty) {
      if (_isNumeric(_itemNameController.text) == true)
      {
        Get.snackbar("Try Again", "Item name can't be a number.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: red,
          backgroundColor: Colors.white,
          icon: Icon(Icons.warning_amber_outlined, color: red));
      } 
      else if (_itemExists(_itemNameController.text) == true) {
        Get.snackbar("Try Again", "Item already exists.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: red,
          backgroundColor: Colors.white,
          icon: Icon(Icons.warning_amber_outlined, color: red));
      }
      else {
        _addItemToDb();
        Get.to(() => InventoryPage(), duration: Duration(milliseconds: 0));
      }
    } else {
      Get.snackbar("Try Again", "Put the name of the item >:(",
          snackPosition: SnackPosition.BOTTOM,
          colorText: red,
          backgroundColor: Colors.white,
          icon: Icon(Icons.warning_amber_outlined, color: red));
    }
  }

  _addItemToDb() async {
    int value = await _itemController.addItem(
        item: Item(
      itemName: _itemNameController.text,
      quantity: 0,
    ));
    print("My id is " + "$value");
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2121));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("it's null or something is wrong");
    }
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
            title: Text("New Item", style: titleStyle),
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
