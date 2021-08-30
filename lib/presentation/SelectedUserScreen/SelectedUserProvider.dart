import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/utils/memory_management.dart';

class SelectedUserProvider extends ChangeNotifier {
  late List<UserListModel> _userlist;

  List<UserListModel> get userlist => _userlist;

  set userlist(List<UserListModel> list) {
    _userlist = list;
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
    if (MemoryManagement.getuserlist() != null) {
      userlist[index].ischecked = onChanged;
      var userlistvalue = json.encode(userlist);
      MemoryManagement.setuserlist(userlist: userlistvalue);
    }
    notifyListeners();
  }

  void globalcheckboc(bool? onChanged) {
    _globalcheckflag = onChanged!;
    if (onChanged == true) {
      userlist.forEach((element) {
        element.ischecked = false;
      });
      if (MemoryManagement.getuserlist() != null) {
        var userlistvalue = json.encode(userlist);
        MemoryManagement.setuserlist(userlist: userlistvalue);
      }

    }
    notifyListeners();
  }

  setloading(bool value){
    _isloading=value;
    notifyListeners();
  }
}
