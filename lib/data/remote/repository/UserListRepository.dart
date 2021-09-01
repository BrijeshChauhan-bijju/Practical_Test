
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:testproject/data/model/user_list_model.dart';
abstract class UserListRepository{
  Future<List<UserListModel>> getUserList(int currentPage,int perpage);

}