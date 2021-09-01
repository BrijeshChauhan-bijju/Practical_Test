import 'dart:async';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/UserListApi/UserListApi.dart';
import 'package:testproject/utils/networkmodel/APIHandler.dart';
import 'package:testproject/utils/networkmodel/APIs.dart';
import 'package:testproject/utils/networkmodel/api_error.dart';

class UserListApiImpl implements UserListApi {
  @override
  Future<List<UserListModel>> getuserlist(int currentPage, int perpage) async {
    Response response = await APIHandler.get(
      url: "${APIs.userlist}?since=$currentPage&per_page=$perpage",
    );

    if (response.statusCode == 200) {
      List<UserListModel> responselist = [];
      response.data.forEach((element) {
        UserListModel postEntity = UserListModel.fromJson(element);
        responselist.add(postEntity);
      });
      return responselist;
    }else{
      throw response.statusMessage!;
    }
  }
}
