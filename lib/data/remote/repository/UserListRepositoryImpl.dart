import 'package:flutter/cupertino.dart';
import 'package:testproject/data/remote/UserListApi/UserListApi.dart';
import 'package:testproject/data/remote/repository/UserListRepository.dart';

class UserListRepositoryImpl implements UserListRepository {
  late UserListApi _userListApi;

  UserListRepositoryImpl(UserListApi userListApi) {
    this._userListApi = userListApi;
  }

  @override
  Future<dynamic> getUserList(BuildContext context) {
    return _userListApi.getuserlist(context);
  }
}
