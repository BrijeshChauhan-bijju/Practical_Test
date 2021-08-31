import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:testproject/data/remote/UserListApi/UserListApi.dart';
import 'package:testproject/utils/networkmodel/APIHandler.dart';
import 'package:testproject/utils/networkmodel/APIs.dart';
import 'package:testproject/utils/networkmodel/api_error.dart';

class UserListApiImpl implements UserListApi {
  @override
  Future<dynamic> getuserlist(
      BuildContext context, int currentPage, int perpage) async {

    var response = await APIHandler.get(
        url: "${APIs.userlist}?since=$currentPage&per_page=$perpage",
        context: context);
    if (response is ApiError) {
      return response;
    } else {
      return response;
    }
  }
}
