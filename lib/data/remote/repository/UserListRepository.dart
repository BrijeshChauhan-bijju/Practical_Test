
import 'package:flutter/cupertino.dart';
abstract class UserListRepository{
  Future<dynamic> getUserList(BuildContext context,int currentPage,int perpage);

}