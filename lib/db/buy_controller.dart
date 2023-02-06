import 'package:get/get.dart';
import 'package:inventory/db/buy.dart';
import 'package:inventory/db/db_helper.dart';

class BuyController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var buyList = <Buy>[].obs;

  Future<int> addBuy({Buy? buy}) async {
    return await DBHelper.insertBuy(buy);
  }

  void getBuy(String itemName) async {
    List<Map<String, dynamic>> buyItemsList = await DBHelper.getBuy(itemName);
    buyList.assignAll(buyItemsList.map((data) => new Buy.fromJson(data)).toList());
  }

  void delete(Buy buy, String itemName) {
    DBHelper.deleteBuy(buy);
    getBuy(itemName);
  }
}
