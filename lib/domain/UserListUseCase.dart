import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/repository/UserListRepository.dart';
import 'package:testproject/domain/BaseUseCase.dart';

class UserListUseCase extends BaseUseCase<dynamic> {
  late UserListRepository _userListRepository;

  UserListUseCase(UserListRepository userListRepository) {
    this._userListRepository = userListRepository;
  }

  @override
  Future<List<UserListModel>> perform([currentPage,perpage]) {
    return _userListRepository.getUserList(currentPage,perpage);
  }
}
