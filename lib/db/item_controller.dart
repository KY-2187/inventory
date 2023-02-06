import 'package:get/get.dart';
import 'package:inventory/db/db_helper.dart';
import 'package:inventory/db/item.dart';

class ItemController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var itemList = <Item>[].obs;

  Future<int> addItem({Item? item}) async {
    return await DBHelper.insertItem(item);
  }

  Future<List> getDistinctItems() async {
    List<Map<String, dynamic>> distinctItemsList =
        await DBHelper.distinctItems();
    return distinctItemsList;
  }

  Future<List> getQuantity(String itemName) async {
    List<Map<String, dynamic>> quantityList =
        await DBHelper.getQuantity(itemName);
    return quantityList;
  }

  void getItems() async {
    List<Map<String, dynamic>> items = await DBHelper.query();
    itemList.assignAll(items.map((data) => new Item.fromJson(data)).toList());
  }

  void getSearchedItems(String keyword) async {
    List<Map<String, dynamic>> searchItems = await DBHelper.searchItems(keyword);
    itemList.assignAll(searchItems.map((data) => new Item.fromJson(data)).toList());
  }

  void updateQuantity(String itemName, int buyQuantity) async {
    await DBHelper.updateQuantity(itemName, buyQuantity);
  }

  void delete(Item item) {
    DBHelper.deleteItem(item);
    getItems();
  }
}
