import 'package:testproject/data/remote/repository/UserListRepository.dart';
import 'package:testproject/domain/BaseUseCase.dart';

class UserListUseCase extends BaseUseCase<dynamic> {
  late UserListRepository _userListRepository;

  UserListUseCase(UserListRepository userListRepository) {
    this._userListRepository = userListRepository;
  }

  @override
  Future<dynamic> perform([context,currentPage,perpage]) {
    return _userListRepository.getUserList(context,currentPage,perpage);
  }
}
