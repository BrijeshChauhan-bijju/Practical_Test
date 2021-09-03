import 'dart:convert';
import 'package:testproject/datasource/local/memory_management.dart';
import 'package:testproject/datasource/local/user_datastore.dart';
import 'package:testproject/datasource/remote/UserListApi/userlist_api.dart';
import 'package:testproject/domain/model/user_domain.dart';
import 'package:testproject/domain/repository/userlist_repository.dart';
import 'package:testproject/presentation/model/user_item.dart';

class UserListRepositoryImpl implements UserListRepository {
  late UserListApi _userListApi;
  late Userdatastore _userdatastore;

  UserListRepositoryImpl(UserListApi userListApi, Userdatastore userdatastore) {
    this._userListApi = userListApi;
    this._userdatastore = userdatastore;
  }

  @override
  Future<List<UserDomain>> getUserList(int currentPage, int perpage) async {
    List<UserDomain> responselist =
        await _userListApi.getuserlist(currentPage, perpage);

    List<UserDomain> databaselist = await _userdatastore.getfromshared();

    if (databaselist.isNotEmpty) {
      for (int i = 0; i < responselist.length; i++) {
        for (int j = 0; j < databaselist.length; j++) {
          if (responselist[i].id == databaselist[j].id) {
            responselist[i].ischecked = databaselist[j].ischecked;
          }
        }
      }
    }
    return responselist;
  }

  @override
  Future<List<UserDomain>> setcheckbox(
      bool onChanged, UserItem useritem) async {
    List<UserDomain> databaselist = await _userdatastore.getfromshared();

    UserDomain domain = UserDomain();
    domain.id = useritem.id;
    domain.login = useritem.login;
    domain.ischecked = useritem.ischecked;
    domain.avatarUrl = useritem.avatarUrl;

    if (onChanged == true) {
      databaselist.add(domain);
    } else {
      if (databaselist.isNotEmpty) {
        databaselist.removeWhere((element) => element.id == domain.id);
      }
    }

    _userdatastore.savetoshared(databaselist);

    return databaselist;
  }

  @override
  Future<List<UserDomain>> updatelist() async {
    List<UserDomain> databaselist = await _userdatastore.getfromshared();
    return databaselist;
  }

  @override
  Future<List<UserDomain>> updateselectedusercheckbox(
      bool onChanged, UserItem useritem) async {
    List<UserDomain> databaselist = await _userdatastore.getfromshared();
    if (onChanged == false) {
      databaselist.removeWhere((element) => element.id == useritem.id);
    }
    _userdatastore.savetoshared(databaselist);

    return databaselist;
  }

  @override
  List<UserDomain> globalcheck() {
    List<UserDomain> userlist = [];
    _userdatastore.clear();
    return userlist;
  }

  @override
  Future<List<UserDomain>> getfromshared() async {
    List<UserDomain> databaselist = await _userdatastore.getfromshared();
    return databaselist;
  }
}
