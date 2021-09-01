

import 'package:dio/dio.dart';
import 'package:testproject/data/model/user_list_model.dart';

abstract class UserListApi{
  Future<List<UserListModel>> getuserlist(int currentPage,int perpage);
}