
import 'package:flutter/cupertino.dart';

abstract class UserListApi{
  Future<dynamic> getuserlist(BuildContext context,int currentPage,int perpage);
}