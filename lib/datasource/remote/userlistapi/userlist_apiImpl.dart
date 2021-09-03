import 'dart:async';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:testproject/data/entity/user_entity.dart';
import 'package:testproject/datasource/remote/UserListApi/userlist_api.dart';
import 'package:testproject/datasource/remote/request/user_request.dart';
import 'package:testproject/domain/model/user_domain.dart';
import 'package:testproject/utils/networkmodel/APIs.dart';
import 'package:testproject/utils/networkmodel/api_error.dart';

class UserListApiImpl implements UserListApi {
  late UserRequest _userRequest;

  UserListApiImpl(this._userRequest);

  @override
  Future<List<UserDomain>> getuserlist(int currentPage, int perpage) async {
    Response response = await _userRequest.userlist(currentPage, perpage);

    if (response.statusCode == 200) {
      List<UserEntity> responselist = [];
      response.data.forEach((element) {
        UserEntity postEntity = UserEntity.fromJson(element);
        responselist.add(postEntity);
      });

      return responselist.maptoDomainList();
    } else {
      throw response;
    }
  }
}
