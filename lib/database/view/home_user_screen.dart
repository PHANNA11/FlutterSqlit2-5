import 'package:flutter/material.dart';
import 'package:flutter_database/database/data/conn.dart';
import 'package:flutter_database/database/model/user_model.dart';
import 'package:flutter_database/database/view/add_edit_user_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  List<UserModel> userList = [];
  getUserData({int? filterBy}) async {
    await DatabaseHelper().getAllUser(filterBy: filterBy ?? 1).then(
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
      endDrawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Text(
                'MENU SORT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              buildFilterMenu(filterByValue: 1),
              Divider(),
              buildFilterMenu(title: 'Sort by Salary', filterByValue: 2),
              Divider(),
              buildFilterMenu(title: 'Sort by Name(Z-A)', filterByValue: 3),
              buildFilterMenu(title: 'Sort by Name(A-Z)', filterByValue: 4),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('DATABASE'),
      ),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) => Slidable(
                key: const ValueKey(0),

                // The end action pane is the one at the right or the bottom side.
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditUserScreen(
                                isAdd: false,
                                user: userList[index],
                              ),
                            ));
                        // await DatabaseHelper()
                        //     .updateUser(
                        //         user: UserModel(
                        //             id: userList[index].id,
                        //             name: 'Rathana',
                        //             salary: userList[index].salary))
                        //     .whenComplete(
                        //       () => getUserData(),
                        //     );
                      },
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(10)),
                      backgroundColor: Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (context) async {
                        await DatabaseHelper()
                            .deleteUser(id: userList[index].id!)
                            .whenComplete(
                              () => getUserData(),
                            );
                      },
                      backgroundColor: Color(0xFF0392CF),
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(10)),
                      foregroundColor: Colors.red,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),

                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.person_pin_rounded),
                    title: Text(userList[index].name!),
                    subtitle: Text('\$ ${userList[index].salary!}'),
                  ),
                ),
              )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditUserScreen(
                    isAdd: true,
                  ),
                ));
          },
          label: Text('Add')),
    );
  }

  Widget buildFilterMenu({required int? filterByValue, String? title}) {
    return ListTile(
      onTap: () async {
        getUserData(filterBy: filterByValue);
      },
      leading: Icon(Icons.sort),
      title: Text(title ?? 'Defult'),
    );
  }
}
