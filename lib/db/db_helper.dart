import 'package:inventory/db/buy.dart';
import 'package:inventory/db/item.dart';
import 'package:inventory/db/use.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _itemTable = "itemTable";
  static final String _buyTable = "buyTable";
  static final String _useTable = "useTable";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'items.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("creating a new one");
          db.execute("CREATE TABLE $_itemTable("
              "itemName STRING PRIMARY KEY, "
              "quantity INTEGER)");
          db.execute("CREATE TABLE $_buyTable("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "itemName STRING, buyQuantity INTEGER, location STRING, "
              "price STRING, date STRING, "
              "isUsed INTEGER, "
              "FOREIGN KEY (itemName) REFERENCES $_itemTable(itemName) ON DELETE NO ACTION ON UPDATE NO ACTION)");
          db.execute("CREATE TABLE $_useTable("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "itemName STRING, "
              "useQuantity INTEGER, "
              "date STRING, "
              "FOREIGN KEY (itemName) REFERENCES $_itemTable(itemName) ON DELETE NO ACTION ON UPDATE NO ACTION)");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertItem(Item? item) async {
    print("insert function called");
    return await _db?.insert(_itemTable, item!.toJson()) ?? 1;
  }

  static Future<int> insertBuy(Buy? buy) async {
    print("insert function called");
    return await _db?.insert(_buyTable, buy!.toJson()) ?? 1;
  }

  static Future<int> insertUse(Use? use) async {
    print("insert function called");
    return await _db?.insert(_useTable, use!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_itemTable, orderBy: "itemName ASC");
  }

  static Future<List<Map<String, dynamic>>> distinctItems() async {
    return await _db!.query(_itemTable, columns: ['itemName']);
  }

  static Future<List<Map<String, dynamic>>> searchItems(String keyword) async {
    return await _db!.query(_itemTable, where: 'itemName LIKE ?', whereArgs: ['%$keyword%']);
  }

  static Future<List<Map<String, dynamic>>> getQuantity(String itemName) async {
    return await _db!.query(
        _itemTable, columns: ['quantity'], where: 'itemName=?', whereArgs: [itemName]);
  }

  static Future<List<Map<String, dynamic>>> getBuy(String itemName) async {
    return await _db!.rawQuery('''
      SELECT * FROM $_buyTable
      INNER JOIN $_itemTable
      ON $_buyTable.itemName = ? AND $_itemTable.itemName = ?
      ORDER BY $_buyTable.id DESC
      ''', [itemName, itemName]);
  }

  static Future<List<Map<String, dynamic>>> getUse(String itemName) async {
    return await _db!.rawQuery('''
      SELECT * FROM $_useTable
      INNER JOIN $_itemTable
      ON $_useTable.itemName = ? AND $_itemTable.itemName = ?
      ORDER BY $_useTable.id DESC
      ''', [itemName, itemName]);
  }

  static updateQuantity(String itemName, int newQuantity) async {
    return await _db!.rawUpdate(''' 
      UPDATE $_itemTable
      SET quantity = ?
      where itemName = ?
    ''', [newQuantity, itemName]);
  }

  static deleteItem(Item item) async {
    return await _db!
        .delete(_itemTable, where: 'itemName = ?', whereArgs: [item.itemName]);
  }

  static deleteBuy(Buy buy) async {
    return await _db!.delete(_buyTable, where: 'id = ?', whereArgs: [buy.id]);
  }

  static deleteUse(Use use) async {
    return await _db!.delete(_useTable, where: 'id = ?', whereArgs: [use.id]);
  }
}
