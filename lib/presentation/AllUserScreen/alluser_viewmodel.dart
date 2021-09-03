import 'package:flutter/material.dart';
import 'package:testproject/domain/usecase/setcheckbox_usecase.dart';
import 'package:testproject/domain/usecase/updatelist_usecase.dart';
import 'package:testproject/domain/usecase/userlist_usecase.dart';
import 'package:testproject/presentation/model/user_item.dart';
import 'package:testproject/utils/universalclass.dart';

class AllUserViewModel extends ChangeNotifier {
  UserListUseCase _userListUseCase;

  SetCheckBoxUseCase _setCheckBoxUseCase;

  UpdateListUseCase _updateListUseCase;

  AllUserViewModel(
      this._userListUseCase, this._setCheckBoxUseCase, this._updateListUseCase);

  List<UserItem> _userlist = [];

  List<UserItem> get userlist => _userlist;

  set userlist(List<UserItem> userlistmodel) {
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

  bool _isloading = false;

  bool get isloading => _isloading;

  set isloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void getAllUserList(
    bool isfirst,
  ) async {
    var hasinternet = await hasInternetConnection();
    print("hasinternet=>,${hasinternet}");
    if (hasinternet) {
      if (isdataloaded == false) {
        if (isfirst) {
          setLoading(true);
          userlist.clear();
        }
        isdataloading = true;
        List<UserItem> responselist =
            await _userListUseCase.perform(currentPage, perpage);

        if (responselist.length < perpage) {
          isdataloaded = true;
        }
        userlist.addAll(responselist);

        if (userlist.isNotEmpty) {
          currentPage = userlist[userlist.length - 1].id!;
        } else {
          error = "No Data Found";
        }

        isdataloading = false;

        // onSuccess(userlist);

        if (isfirst) {
          setLoading(false);
        }
      }
    } else {
      error = "Please connect to internet";
    }
    notifyListeners();
  }

  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void setCheckBox(bool? onChanged, int index) async {
    userlist[index].ischecked = onChanged;
    await _setCheckBoxUseCase.perform(onChanged, userlist[index]);
    notifyListeners();
  }

  void updateCheckList() async {
    print("1=>");
    List<UserItem> checkeduserlist = await _updateListUseCase.perform();

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
