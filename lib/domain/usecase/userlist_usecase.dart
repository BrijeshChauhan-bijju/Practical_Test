import 'package:testproject/domain/repository/userlist_repository.dart';
import 'package:testproject/domain/usecase/base_usecase.dart';
import 'package:testproject/presentation/model/user_item.dart';

class UserListUseCase extends BaseUseCase<dynamic> {
  late UserListRepository _userListRepository;

  UserListUseCase(UserListRepository userListRepository) {
    this._userListRepository = userListRepository;
  }

  @override
  Future<List<UserItem>> perform([currentPage,perpage]) {
    return _userListRepository.getUserList(currentPage,perpage).then((userInfo) {
      return userInfo.mapToPresentationList();
    });
    // return _userListRepository.getUserList(currentPage,perpage).;
  }
}
