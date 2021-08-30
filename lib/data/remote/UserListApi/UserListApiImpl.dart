import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:testproject/data/remote/UserListApi/UserListApi.dart';
import 'package:testproject/utils/networkmodel/APIHandler.dart';
import 'package:testproject/utils/networkmodel/APIs.dart';
import 'package:testproject/utils/networkmodel/api_error.dart';

class UserListApiImpl implements UserListApi {
  @override
  Future<dynamic> getuserlist(BuildContext context) async {
    Completer<dynamic> completer = new Completer<dynamic>();
    var response = await APIHandler.get(
        url: "${APIs.userlist}", context: context);
    if (response is ApiError) {
      completer.complete(response);
      return completer.future;
    } else {
      completer.complete(response);
      return completer.future;
    }
  }
}
