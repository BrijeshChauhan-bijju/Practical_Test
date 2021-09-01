import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/datasource/memory_management.dart';

class SelectedUserProvider extends ChangeNotifier {
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
    if (MemoryManagement.getuserlist() != null) {
      if (onChanged == false) {
        userlist.remove(userlist[index]);
      }

      var userlistvalue = json.encode(userlist);
      MemoryManagement.setuserlist(userlist: userlistvalue);
    }
    notifyListeners();
  }

  void globalcheckboc(bool? onChanged) {
    _globalcheckflag = onChanged!;
    if (onChanged == true) {
      userlist.clear();
      if (MemoryManagement.getuserlist() != null) {
        var userlistvalue = json.encode(userlist);
        MemoryManagement.setuserlist(userlist: userlistvalue);
      }
    }
    notifyListeners();
  }

  void fetchdata() async {
    setloading(true);
    userlist.clear();
    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
          await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserListModel postEntity = UserListModel.fromJson(element);
        userlist.add(postEntity);
      });
    }
    setloading(false);
  }

  setloading(bool value) {
    _isloading = value;
    notifyListeners();
  }
}
