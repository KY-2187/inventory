import 'package:get/get.dart';
import 'package:inventory/db/db_helper.dart';
import 'package:inventory/db/use.dart';

class UseController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var useList = <Use>[].obs;

  Future<int> addUse({Use? use}) async {
    return await DBHelper.insertUse(use);
  }

  void getUse(String itemName) async {
    List<Map<String, dynamic>> useItemsList = await DBHelper.getUse(itemName);
    useList.assignAll(useItemsList.map((data) => new Use.fromJson(data)).toList());
  }

  void delete(Use use, String itemName) {
    DBHelper.deleteUse(use);
    getUse(itemName);
  }
}
