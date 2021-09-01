import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:testproject/data/model/user_list_model.dart';

abstract class UserListRepository {
  Future<List<UserListModel>> getUserList(int currentPage, int perpage);

  Future<List<UserListModel>> setcheckbox(
      bool onChanged, List<UserListModel> userlist, int index);

  Future<List<UserListModel>> updatelist(List<UserListModel> userlist);

  List<UserListModel> updateselectedusercheckbox(bool onChanged,List<UserListModel> userlist,int index);
  List<UserListModel> globalcheck(bool onChanged,List<UserListModel> userlist);
  Future<List<UserListModel>> getfromshared(List<UserListModel> Listuserlist);
}
