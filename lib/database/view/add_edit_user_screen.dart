import 'package:flutter/material.dart';
import 'package:flutter_database/database/model/user_model.dart';
import 'package:flutter_database/database/widget/textfield_cos_widget.dart';

import '../data/conn.dart';

class AddEditUserScreen extends StatefulWidget {
  AddEditUserScreen({super.key, required this.isAdd, this.user});
  bool isAdd;
  UserModel? user;

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  void clearData() {
    setState(() {
      nameController.text = '';
      salaryController.text = '';
    });
  }

  void initData() {
    setState(() {
      nameController.text = widget.user!.name!;
      salaryController.text = widget.user!.salary!.toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isAdd ? clearData() : initData();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.isAdd ? 'ADD USER INFO' : 'EDIT USER INFO'),
      ),
      body: Column(
        spacing: 15,
        children: [
          MyTextfieldWidget(
            controller: nameController,
            labelText: 'Enter Name',
          ),
          MyTextfieldWidget(
            controller: salaryController,
            labelText: 'Enter salary',
            hintText: 'Enter salary \$',
            keyboardType: TextInputType.number,
          ),
          // MyTextfieldWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:
            widget.isAdd ? Colors.lightBlue : Colors.lightBlueAccent,
        onPressed: () async {
          if (nameController.text.isNotEmpty &&
              salaryController.text.isNotEmpty) {
            widget.isAdd
                ? await DatabaseHelper()
                    .insertUserData(
                        user: UserModel(
                            name: nameController.text,
                            salary: double.parse(salaryController.text)))
                    .then((status) {
                    if (status) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User was added')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Add user false')));
                    }
                  })
                : await DatabaseHelper()
                    .updateUser(
                        user: UserModel(
                            id: widget.user!.id,
                            name: nameController.text,
                            salary: double.parse(salaryController.text)))
                    .then((status) {
                    if (status) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User was updated')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Update user false')));
                    }
                  });
          }
        },
        icon: Icon(widget.isAdd ? Icons.add : Icons.done),
        label: Text(widget.isAdd ? 'Add user' : 'Save'),
      ),
    );
  }
}
