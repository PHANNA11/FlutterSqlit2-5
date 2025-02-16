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

  Future<void> insertUserData({required UserModel user}) async {
    var db = await initDatabse();
    await db.insert(userTableName, user.toMap(isAdd: true));
    log('Data inserted');
  }

  // read data

  Future<List<UserModel>> getAllUser() async {
    var db = await initDatabse();
    List<Map<String, dynamic>> result = await db.query(userTableName);
    return result.map((e) => UserModel.fromMap(data: e)).toList();
  }
}
