
import 'package:flutter/cupertino.dart';
abstract class UserListRepository{
  Future<dynamic> getUserList(int currentPage,int perpage);

}