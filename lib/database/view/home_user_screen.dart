import 'package:flutter/material.dart';
import 'package:flutter_database/database/data/conn.dart';
import 'package:flutter_database/database/model/user_model.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  List<UserModel> userList = [];
  getUserData() async {
    await DatabaseHelper().getAllUser().then(
      (value) {
        setState(() {
          userList = value;
        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATABASE'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            onLongPress: () async {
              await DatabaseHelper()
                  .updateUser(
                      user: UserModel(
                          id: userList[index].id,
                          name: 'Rathana',
                          salary: userList[index].salary))
                  .whenComplete(
                    () => getUserData(),
                  );
            },
            leading: Icon(Icons.person_pin_rounded),
            title: Text(userList[index].name!),
            subtitle: Text('\$ ${userList[index].salary!}'),
            trailing: IconButton(
                onPressed: () async {
                  await DatabaseHelper()
                      .deleteUser(id: userList[index].id!)
                      .whenComplete(
                        () => getUserData(),
                      );
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await DatabaseHelper()
                .insertUserData(user: UserModel(name: 'kanha', salary: 200.00))
                .whenComplete(() => getUserData());
          },
          label: Text('Add')),
    );
  }
}
