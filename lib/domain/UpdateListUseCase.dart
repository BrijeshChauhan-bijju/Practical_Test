import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/repository/UserListRepository.dart';
import 'package:testproject/domain/BaseUseCase.dart';

class UpdateListUseCase extends BaseUseCase<dynamic> {
  late UserListRepository _userListRepository;

  UpdateListUseCase(UserListRepository userListRepository) {
    this._userListRepository = userListRepository;
  }

  @override
  Future<List<UserListModel>> perform([userlist]) {
    return _userListRepository.updatelist(userlist);
  }
}
