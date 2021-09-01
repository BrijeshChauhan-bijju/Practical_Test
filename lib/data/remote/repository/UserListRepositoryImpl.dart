import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/UserListApi/UserListApi.dart';
import 'package:testproject/data/remote/repository/UserListRepository.dart';

class UserListRepositoryImpl implements UserListRepository {
  late UserListApi _userListApi;

  UserListRepositoryImpl(UserListApi userListApi) {
    this._userListApi = userListApi;
  }

  @override
  Future<List<UserListModel>> getUserList(int currentPage,int perpage) {
    return _userListApi.getuserlist(currentPage,perpage);
  }
}
