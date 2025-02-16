import 'package:flutter_database/database/data/conn.dart';

class UserModel {
  int? id;
  String? name;
  double? salary;
  UserModel({this.id, this.name, this.salary});

  UserModel.fromMap({required Map data})
      : id = data[uid],
        name = data[uName],
        salary = data[uSalary];

  Map<String, dynamic> toMap({bool? isAdd}) {
    return {
      if (!(isAdd ?? false)) uid: id,
      uName: name,
      uSalary: salary,
    };
  }
}
