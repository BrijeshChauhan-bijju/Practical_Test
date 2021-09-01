import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/UserListApi/UserListApiImpl.dart';
import 'package:testproject/data/remote/repository/UserListRepositoryImpl.dart';
import 'package:testproject/domain/SetCheckBoxUseCase.dart';
import 'package:testproject/domain/UpdateListUseCase.dart';
import 'package:testproject/domain/UserListUseCase.dart';
import 'package:testproject/datasource/memory_management.dart';
import 'package:testproject/utils/networkmodel/api_error.dart';

class AllUserListProvider extends ChangeNotifier {
  UserListUseCase _userListUseCase =
      UserListUseCase(UserListRepositoryImpl(UserListApiImpl()));

  SetCheckBoxUseCase _setCheckBoxUseCase =
      SetCheckBoxUseCase(UserListRepositoryImpl(UserListApiImpl()));

  UpdateListUseCase _updateListUseCase =
      UpdateListUseCase(UserListRepositoryImpl(UserListApiImpl()));

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

    if (responselist.length < perpage) {
      isdataloaded = true;
    }
    userlist.addAll(responselist);

    currentPage = userlist[userlist.length - 1].id!;

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
    // List<UserListModel> responselist =
    await _setCheckBoxUseCase.perform(onChanged, userlist, index);
    notifyListeners();
  }

  void updateCheckList() async {
    print("1=>");
    _updateListUseCase.perform(userlist);
    notifyListeners();
  }
}
