import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/user_model.dart';

String userTableName = 'users';
String uid = 'id';
String uName = 'name';
String uSalary = 'salary';

class DatabaseHelper {
  // init or Create
  Future<Database> initDatabse() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE $userTableName ($uid INTEGER PRIMARY KEY AUTOINCREMENT, $uName TEXT, $uSalary REAL)');
    });
  }
  // insert

  Future<bool> insertUserData({required UserModel user}) async {
    var db = await initDatabse();
    var status = await db.insert(userTableName, user.toMap(isAdd: true));

    return status >= 1 ? true : false;
  }

  // read data

  Future<List<UserModel>> getAllUser({int? filterBy}) async {
    var db = await initDatabse();
    List<Map<String, dynamic>> result = await db.query(userTableName,
        // columns: [uSalary],
        orderBy: getFilterByValue(value: filterBy ?? 1));
    return result.map((e) => UserModel.fromMap(data: e)).toList();
  }

  // Delete data
  Future<bool> updateUser({required UserModel user}) async {
    var db = await initDatabse();
    var status = await db.update(userTableName, user.toMap(),
        where: '$uid=?', whereArgs: [user.id]);
    return status >= 1 ? true : false;
  }

  // Update Data
  Future<void> deleteUser({required int id}) async {
    var db = await initDatabse();
    await db.delete(userTableName, where: '$uid=?', whereArgs: [id]);
  }

  String? getFilterByValue({required int value}) {
    switch (value) {
      case 1:
        return null;
      case 2:
        return '$uSalary DESC';
      case 3:
        return '$uName DESC';
      case 4:
        return '$uName ASC';
    }
    return null;
  }
}
