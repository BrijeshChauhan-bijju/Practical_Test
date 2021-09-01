import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/UserListApi/UserListApiImpl.dart';
import 'package:testproject/data/remote/repository/UserListRepositoryImpl.dart';
import 'package:testproject/datasource/memory_management.dart';
import 'package:testproject/domain/GetDataFromSharedPrefUseCase.dart';
import 'package:testproject/domain/GlobalCheckUseCase.dart';
import 'package:testproject/domain/SelectedUserCheckBoxUseCase.dart';

class SelectedUserProvider extends ChangeNotifier {
  SelectedUserCheckBoxUseCase _selectedUserCheckBoxUseCase =
      SelectedUserCheckBoxUseCase(UserListRepositoryImpl(UserListApiImpl()));

  GlobalCheckBoxUseCase _globalCheckBoxUseCase =
      GlobalCheckBoxUseCase(UserListRepositoryImpl(UserListApiImpl()));

  GetDatFromSharedPref _getDatFromSharedPref =
      GetDatFromSharedPref(UserListRepositoryImpl(UserListApiImpl()));

  List<UserListModel> _userlist = [];

  List<UserListModel> get userlist => _userlist;

  set userlist(List<UserListModel> list) {
    _userlist = list;
    notifyListeners();
  }

  bool _isdataloaded = false;

  bool get isdataloaded => _isdataloaded;

  set isdataloaded(bool value) {
    _isdataloaded = value;
    notifyListeners();
  }

  bool _isloading = true;

  get isloading => _isloading;

  bool _globalcheckflag = false;

  bool get globalcheckflag => _globalcheckflag;

  set globalcheckflag(bool globalvalue) {
    _globalcheckflag = globalvalue;
    notifyListeners();
  }

  void setcheckbox(bool? onChanged, int index) {
    userlist[index].ischecked = onChanged;

    _selectedUserCheckBoxUseCase.perform(onChanged, userlist, index);

    notifyListeners();
  }

  void globalcheckboc(bool? onChanged) async {
    _globalcheckflag = onChanged!;
    userlist = await _globalCheckBoxUseCase.perform(onChanged, userlist);
    notifyListeners();
  }

  void fetchdata() async {
    setloading(true);
    userlist.clear();
    userlist = await _getDatFromSharedPref.perform(userlist);

    setloading(false);
  }

  setloading(bool value) {
    _isloading = value;
    notifyListeners();
  }
}
