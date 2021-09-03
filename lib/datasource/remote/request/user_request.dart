import 'package:dio/dio.dart';
import 'package:testproject/data/entity/user_entity.dart';
import 'package:testproject/utils/networkmodel/APIHandler.dart';
import 'package:testproject/utils/networkmodel/APIs.dart';

class UserRequest {
  ///Sign in user
  Future<Response> userlist(int currentPage, int perpage) async {
    Response response = await APIHandler.get(
      url: "${APIs.userlist}?since=$currentPage&per_page=$perpage",
    );
    return response;
  }
}
