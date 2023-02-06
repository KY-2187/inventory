import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:inventory/db/item_controller.dart';
import 'package:inventory/db/use.dart';
import 'package:inventory/db/use_controller.dart';
import 'package:inventory/pages/home_page.dart';
import 'package:inventory/pages/inventory_page.dart';
import 'package:inventory/pages/search_page.dart';
import 'package:inventory/pages/settings_page.dart';
import 'package:inventory/theme.dart';
import 'package:inventory/util/input_field.dart';
import 'package:inventory/util/money_input_field.dart';
import 'package:inventory/util/submit_button.dart';

class UsePage extends StatefulWidget {
  const UsePage({Key? key}) : super(key: key);

  @override
  State<UsePage> createState() => _UsePageState();
}

class _UsePageState extends State<UsePage> {
  final _itemController = Get.put(ItemController());
  final _useController = Get.put(UseController());
  late Future<List> futureList = _itemController.getDistinctItems();
  final TextEditingController _quantityController = TextEditingController();
  List<String> itemsList = [];
  List<int> finalQuantity = [];
  String _selectedItem = "Select item";
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
                    hint: "$_selectedItem",
                    widget: DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: GoogleFonts.lato(color: Colors.grey[400]),
                      underline: Container(height: 0),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem = newValue!;
                        });
                      },
                      items: itemsList
                          .map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value!,
                                style: TextStyle(color: Colors.grey)));
                      }).toList(),
                    )),
                MyInputField(
                    title: "Quantity",
                    hint: "0",
                    controller: _quantityController,
                    keyboardType: TextInputType.number),
                MyInputField(
                    title: "Date",
                    hint: DateFormat.yMd().format(_selectedDate),
                    widget: IconButton(
                        icon: Icon(Icons.calendar_today_outlined,
                            color: Colors.grey),
                        onPressed: () {
                          _getDateFromUser();
                        })),
                SizedBox(height: 16),
                SubmitButton(buttonLabel: "Submit", onTap: () => _validateForm())
              ],
            ),
          ),
        ));
  }

  int counter = 0;
  void _convertFutureListToList() async {
    List list = await futureList;
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

  int counter2 = 0;
  int test = 0;
  Future<int> _subtractQuantity() async {
    late Future<List> futureQuantity = _itemController.getQuantity(_selectedItem);
    List list = await futureQuantity;
    if (counter2 == 0)
    {
      list.forEach((element) {
        setState(() {
          finalQuantity.add(element['quantity']);
          test = finalQuantity[0];
          test = test - int.parse(_quantityController.text);
        }); 
      });
      counter2++;
    }
    return test;
  }

  _validateForm() async {
    if (_selectedItem != "Select Item" &&
        _quantityController.text.isNotEmpty) {
          int newQuantity = await _subtractQuantity();
          _itemController.updateQuantity(_selectedItem, newQuantity);
          _addUseToDb();
          Get.to(() => InventoryPage(), duration: Duration(milliseconds: 0));
    } else if (_selectedItem == "Select item" ||
        _quantityController.text.isEmpty) {
          Get.snackbar("Try Again", "All fields are required!",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.white,
            icon: Icon(Icons.warning_amber_outlined, color: Colors.red));
    }
  }

  _addUseToDb() async {
    int value = await _useController.addUse(
        use: Use(
      itemName: _selectedItem,
      useQuantity: int.parse(_quantityController.text),
      date: DateFormat.yMd().format(_selectedDate)
    ));
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
            title: Text("Use Item", style: titleStyle),
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
