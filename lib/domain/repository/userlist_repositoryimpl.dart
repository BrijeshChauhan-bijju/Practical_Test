import 'dart:convert';
import 'package:testproject/datasource/local/memory_management.dart';
import 'package:testproject/datasource/remote/UserListApi/userlist_api.dart';
import 'package:testproject/domain/model/user_domain.dart';
import 'package:testproject/domain/repository/userlist_repository.dart';
import 'package:testproject/presentation/model/user_item.dart';

class UserListRepositoryImpl implements UserListRepository {
  late UserListApi _userListApi;

  UserListRepositoryImpl(UserListApi userListApi) {
    this._userListApi = userListApi;
  }

  @override
  Future<List<UserDomain>> getUserList(int currentPage, int perpage) async {
    List<UserDomain> list =
        await _userListApi.getuserlist(currentPage, perpage);

    List<UserDomain> checkeduserlist = [];
    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
          await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserDomain postEntity = UserDomain.fromJson(element);
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
  Future<List<UserDomain>> setcheckbox(
      bool onChanged, UserItem useritem) async {
    List<UserDomain> _checkeduserlist = [];
    var sharedpreflist =
        await jsonDecode(MemoryManagement.getuserlist().toString());
    if (sharedpreflist != null) {
      sharedpreflist.forEach((element) {
        UserDomain postEntity = UserDomain.fromJson(element);
        _checkeduserlist.add(postEntity);
      });
    }
    UserDomain domain = UserDomain();
    domain.id = useritem.id;
    domain.login = useritem.login;
    domain.ischecked = useritem.ischecked;
    domain.avatarUrl = useritem.avatarUrl;

    if (onChanged == true) {
      _checkeduserlist.add(domain);
    } else {
      if (sharedpreflist.isNotEmpty) {
        _checkeduserlist.removeWhere((element) => element.id == domain.id);
      }
    }

    var userlistvalue = json.encode(_checkeduserlist);
    MemoryManagement.setuserlist(userlist: userlistvalue);
    return _checkeduserlist;
  }

  @override
  Future<List<UserDomain>> updatelist() async {
    List<UserDomain> checkeduserlist = [];
    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
          await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserDomain postEntity = UserDomain.fromJson(element);
        checkeduserlist.add(postEntity);
      });
    }

    return checkeduserlist;
  }

  @override
  Future<List<UserDomain>> updateselectedusercheckbox(
      bool onChanged, UserItem useritem) async {
    List<UserDomain> checkeduserlist = [];
    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
          await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserDomain postEntity = UserDomain.fromJson(element);
        checkeduserlist.add(postEntity);
      });

      if (onChanged == false) {
        checkeduserlist.removeWhere((element) => element.id == useritem.id);
      }
    }
    var userlistvalue = json.encode(checkeduserlist);
    MemoryManagement.setuserlist(userlist: userlistvalue);

    return checkeduserlist;
  }

  @override
  List<UserDomain> globalcheck() {
    List<UserDomain> userlist=[];
    // if (onChanged == true) {
    //   if (MemoryManagement.getuserlist() != null) {
    //     var userlistvalue = json.encode(userlist);
        MemoryManagement.clearMemory();
    //   }
    // }
    return userlist;
  }

  @override
  Future<List<UserDomain>> getfromshared() async {
    List<UserDomain> userlist = [];
    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
          await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserDomain postEntity = UserDomain.fromJson(element);
        userlist.add(postEntity);
      });
    }
    print("userlist=>,${userlist}");
    return userlist;
  }
}
