import 'package:flutter/material.dart';
import 'package:testproject/domain/usecase/globalcheck_usecase.dart';
import 'package:testproject/domain/usecase/selecteduser_usecase.dart';
import 'package:testproject/domain/usecase/sharedpref_usecase.dart';
import 'package:testproject/presentation/model/user_item.dart';

class SelectedUserViewModel extends ChangeNotifier {
  SelectedUserCheckBoxUseCase _selectedUserCheckBoxUseCase;

  GlobalCheckBoxUseCase _globalCheckBoxUseCase;

  GetDataFromSharedPrefUseCase _getDatFromSharedPref;

  SelectedUserViewModel(this._selectedUserCheckBoxUseCase,
      this._globalCheckBoxUseCase, this._getDatFromSharedPref);

  List<UserItem> _userlist = [];

  List<UserItem> get userlist => _userlist;

  set userlist(List<UserItem> list) {
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

  void setcheckbox(bool? onChanged, int index) async {
    userlist =
        await _selectedUserCheckBoxUseCase.perform(onChanged, userlist[index]);

    notifyListeners();
  }

  void globalcheckboc(bool? onChanged) async {
    _globalcheckflag = onChanged!;
    if (onChanged == true) {
      await _globalCheckBoxUseCase.perform();
      userlist.clear();
    }
    notifyListeners();
  }

  void fetchdata() async {
    setloading(true);
    userlist.clear();
    _globalcheckflag = false;
    userlist = await _getDatFromSharedPref.perform();

    setloading(false);
  }

  setloading(bool value) {
    _isloading = value;
    notifyListeners();
  }
}
