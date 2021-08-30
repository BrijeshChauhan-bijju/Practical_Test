import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/UserListApi/UserListApiImpl.dart';
import 'package:testproject/data/remote/repository/UserListRepositoryImpl.dart';
import 'package:testproject/domain/UserListUseCase.dart';
import 'package:testproject/utils/memory_management.dart';
import 'package:testproject/utils/networkmodel/api_error.dart';

class AllUserListProvider extends ChangeNotifier {
  UserListUseCase _userListUseCase =
      UserListUseCase(UserListRepositoryImpl(UserListApiImpl()));

  List<UserListModel> _userlist = [];

  List<UserListModel> get userlist => _userlist;

  set userlist(List<UserListModel> userlistmodel) {
    _userlist = userlistmodel;
    notifyListeners();
  }

  bool _isloading = true;

  get isloading => _isloading;

  void getAllUserList(
      BuildContext context,
      Function(List<UserListModel> _userlist) onSuccess,
      Function(String error) onFailure) async {
    setloading(true);
    var response = await _userListUseCase.perform(context);

    if (response is ApiError) {
      onFailure("Some thing went wrong");
    } else {
      List<UserListModel> checkeduserlist = [];
      if (MemoryManagement.getuserlist() != null) {
        print("address=>${MemoryManagement.getuserlist().toString()}");
        var sharedpreflist =
            await jsonDecode(MemoryManagement.getuserlist().toString());
        // List<UserListModel> _alluserlist = [];
        sharedpreflist.forEach((element) {
          UserListModel postEntity = UserListModel.fromJson(element);
          checkeduserlist.add(postEntity);
        });
      }
      response.forEach((element) {
        UserListModel postEntity = UserListModel.fromJson(element);
        userlist.add(postEntity);
      });
      if(checkeduserlist.isNotEmpty) {
        userlist = checkeduserlist;
      }

      onSuccess(userlist);
    }

    setloading(false);
    notifyListeners();
  }

  setloading(bool value){
    _isloading=value;
    notifyListeners();
  }

  void setcheckbox(bool? onChanged, int index) {
    userlist[index].ischecked = onChanged;
    var userlistvalue = json.encode(userlist);
    MemoryManagement.setuserlist(userlist: userlistvalue);
    notifyListeners();
  }
}
