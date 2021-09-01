import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/repository/UserListRepository.dart';
import 'package:testproject/domain/BaseUseCase.dart';

class GlobalCheckBoxUseCase extends BaseUseCase<dynamic> {
  late UserListRepository _userListRepository;

  GlobalCheckBoxUseCase(UserListRepository userListRepository) {
    this._userListRepository = userListRepository;
  }

  @override
  Future<List<UserListModel>> perform([onChanged,userlist]) async{
    return await _userListRepository.globalcheck(onChanged,userlist);
  }
}
