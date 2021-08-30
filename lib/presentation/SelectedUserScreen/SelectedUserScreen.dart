import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/presentation/AllUserScreen/AllUserListProvider.dart';
import 'package:testproject/presentation/SelectedUserScreen/SelectedUserProvider.dart';
import 'package:testproject/utils/AppColors.dart';
import 'package:testproject/utils/UniversalClass.dart';
import 'package:testproject/utils/memory_management.dart';

class SelectedUserScreen extends StatefulWidget {
  SelectedUserScreen();

  @override
  SelectedUserScreenState createState() => SelectedUserScreenState();
}

class SelectedUserScreenState extends State<SelectedUserScreen> {
  late SelectedUserProvider provider;
  List<UserListModel> _userlistmodel = [];

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(milliseconds: 300)).then((value) {
      fetchdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SelectedUserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
              "Selected Users List"
          ),
        ),
        body: provider.isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : builduserlist());
  }

  Widget builduserlist() {
    if (provider.userlist.isEmpty) {
      return  Text("Some thing went wrong");
    } else {
      return Column(
            children: [
              Row(
                children: [
                  Checkbox(
                      value: provider.globalcheckflag,
                      onChanged: (onChanged) {
                        provider.globalcheckboc(onChanged);
                      }),
                  Text("Deselect All")
                ],
              ),
              ListView.builder(
                  itemCount: provider.userlist.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Visibility(
                        visible: provider.userlist[index].ischecked ?? false,
                        child: GestureDetector(
                          onLongPress: () {},
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10000.0),
                                  child: getCatchenewtworkImage(
                                    provider.userlist[index].avatarUrl!,
                                    40,
                                    40,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                new Text(
                                  provider.userlist[index].login!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                Checkbox(
                                    value: provider.userlist[index].ischecked ??
                                        false,
                                    onChanged: (onChanged) {
                                      provider.setcheckbox(onChanged, index);
                                    })
                              ],
                            ),
                          ),
                        ));
                  })
            ],
          );
    }
  }

  void fetchdata() async {
    provider.setloading(true);
    if (MemoryManagement.getuserlist() != null) {
      print("address=>${MemoryManagement.getuserlist().toString()}");
      var sharedpreflist =
          await jsonDecode(MemoryManagement.getuserlist().toString());
      // List<UserListModel> _alluserlist = [];
      sharedpreflist.forEach((element) {
        UserListModel postEntity = UserListModel.fromJson(element);
        _userlistmodel.add(postEntity);
      });
      provider.userlist = _userlistmodel;
      provider.setloading(false);
      // _alluserlist.forEach((element) {
      //   if (element.ischecked == true) _userlistmodel.add(element);
      // });

    }
  }
}
