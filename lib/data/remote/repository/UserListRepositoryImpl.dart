import 'dart:convert';

import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/UserListApi/UserListApi.dart';
import 'package:testproject/data/remote/repository/UserListRepository.dart';
import 'package:testproject/datasource/memory_management.dart';

class UserListRepositoryImpl implements UserListRepository {
  late UserListApi _userListApi;

  UserListRepositoryImpl(UserListApi userListApi) {
    this._userListApi = userListApi;
  }

  @override
  Future<List<UserListModel>> getUserList(int currentPage, int perpage) async {
    List<UserListModel> list =
    await _userListApi.getuserlist(currentPage, perpage);
    List<UserListModel> checkeduserlist = [];
    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
      await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserListModel postEntity = UserListModel.fromJson(element);
        checkeduserlist.add(postEntity);
      });
    }
    if (checkeduserlist.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        for (int j = 0; j < checkeduserlist.length; j++) {
          if (list[i].id == checkeduserlist[j].id) {
            list[i].ischecked = checkeduserlist[j].ischecked;
          }
        }
      }
    }
    return list;
  }

  @override
  Future<List<UserListModel>> setcheckbox(bool onChanged,
      List<UserListModel> userlist, int index) async {
    List<UserListModel> _checkeduserlist = [];
    var sharedpreflist =
    await jsonDecode(MemoryManagement.getuserlist().toString());
    if (sharedpreflist != null) {
      sharedpreflist.forEach((element) {
        UserListModel postEntity = UserListModel.fromJson(element);
        _checkeduserlist.add(postEntity);
      });
    }

    if (onChanged == true) {
      _checkeduserlist.add(userlist[index]);
    } else {
      if (sharedpreflist.isNotEmpty) {
        _checkeduserlist
            .removeWhere((element) => element.id == userlist[index].id);
      }
    }

    var userlistvalue = json.encode(_checkeduserlist);
    MemoryManagement.setuserlist(userlist: userlistvalue);
    return _checkeduserlist;
  }

  @override
  Future<List<UserListModel>> updatelist(List<UserListModel> userlist) async {
    List<UserListModel> checkeduserlist = [];
    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
      await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserListModel postEntity = UserListModel.fromJson(element);
        checkeduserlist.add(postEntity);
      });
    }
    if (checkeduserlist.isNotEmpty) {
      for (int i = 0; i < userlist.length; i++) {
        for (int j = 0; j < checkeduserlist.length; j++) {
          if (userlist[i].id == checkeduserlist[j].id) {
            userlist[i].ischecked = checkeduserlist[j].ischecked;
            break;
          } else {
            userlist[i].ischecked = false;
          }
        }
      }
    } else {
      for (int i = 0; i < userlist.length; i++) {
        userlist[i].ischecked = false;
      }
    }
    return userlist;
  }

  @override
  List<UserListModel> updateselectedusercheckbox(bool onChanged,
      List<UserListModel> userlist, int index) {
    if (MemoryManagement.getuserlist() != null) {
      if (onChanged == false) {
        userlist.remove(userlist[index]);
      }

      var userlistvalue = json.encode(userlist);
      MemoryManagement.setuserlist(userlist: userlistvalue);
    }
    return userlist;
  }

  @override
  List<UserListModel> globalcheck(bool onChanged,
      List<UserListModel> userlist) {
    if (onChanged == true) {
      userlist.clear();
      if (MemoryManagement.getuserlist() != null) {
        var userlistvalue = json.encode(userlist);
        MemoryManagement.setuserlist(userlist: userlistvalue);
      }
    }
    return userlist;
  }

  @override
  Future<List<UserListModel>> getfromshared(List<UserListModel> userlist) async{
    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
          await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserListModel postEntity = UserListModel.fromJson(element);
        userlist.add(postEntity);
      });
    }
    return userlist;
  }
}
