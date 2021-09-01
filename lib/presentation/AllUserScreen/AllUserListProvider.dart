import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/UserListApi/UserListApiImpl.dart';
import 'package:testproject/data/remote/repository/UserListRepositoryImpl.dart';
import 'package:testproject/domain/UserListUseCase.dart';
import 'package:testproject/datasource/memory_management.dart';
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

  int _currentPage = 0;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  String _error = "";

  String get error => _error;

  set error(String value) {
    _error = value;
    notifyListeners();
  }

  bool _isdataloading = false;

  bool get isdataloading => _isdataloading;

  set isdataloading(bool value) {
    _isdataloading = value;
    notifyListeners();
  }

  int _perpage = 10;

  int get perpage => _perpage;

  set perpage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  bool _isdataloaded = false;

  bool get isdataloaded => _isdataloaded;

  set isdataloaded(bool value) {
    _isdataloaded = value;
    notifyListeners();
  }

  bool _isloading = true;

  bool get isloading => _isloading;

  set isloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void getAllUserList(
      bool isfirst,
      Function(List<UserListModel> _userlist) onSuccess,
      Function(String error) onFailure) async {
    if (isfirst) {
      setLoading(true);
      userlist.clear();
    }
    isdataloading = true;
    List<UserListModel> responselist =
        await _userListUseCase.perform(currentPage, perpage);
    List<UserListModel> checkeduserlist = [];
    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
          await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserListModel postEntity = UserListModel.fromJson(element);
        checkeduserlist.add(postEntity);
      });
    }
    if (responselist.length < perpage) {
      isdataloaded = true;
    }
    userlist.addAll(responselist);

    currentPage = userlist[userlist.length - 1].id!;
    if (checkeduserlist.isNotEmpty) {
      for (int i = 0; i < userlist.length; i++) {
        for (int j = 0; j < checkeduserlist.length; j++) {
          if (userlist[i].id == checkeduserlist[j].id) {
            userlist[i].ischecked = checkeduserlist[j].ischecked;
          }
        }
      }
    }
    isdataloading = false;
    onSuccess(userlist);

    if (isfirst) {
      setLoading(false);
    }
    notifyListeners();
  }

  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void setCheckBox(bool? onChanged, int index) async {
    userlist[index].ischecked = onChanged;

    List<UserListModel> _checkeduserlist = [];

    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
          await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserListModel postEntity = UserListModel.fromJson(element);
        _checkeduserlist.add(postEntity);
      });
    }

    if (onChanged == true) {
      _checkeduserlist.add(userlist[index]);
    } else {
      _checkeduserlist
          .removeWhere((element) => element.id == userlist[index].id);
    }

    var userlistvalue = json.encode(_checkeduserlist);
    MemoryManagement.setuserlist(userlist: userlistvalue);
    notifyListeners();
  }

  void updateCheckList() async {
    print("1=>");
    List<UserListModel> checkeduserlist = [];
    if (MemoryManagement.getuserlist() != null) {
      print("4=>");
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
    notifyListeners();
  }
}
