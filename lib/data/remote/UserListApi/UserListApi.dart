
import 'package:flutter/cupertino.dart';
import 'package:testproject/data/model/user_list_model.dart';

abstract class UserListApi{
  Future<dynamic> getuserlist(BuildContext context);
}