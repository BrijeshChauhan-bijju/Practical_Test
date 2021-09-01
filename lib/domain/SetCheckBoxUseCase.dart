import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/repository/UserListRepository.dart';
import 'package:testproject/domain/BaseUseCase.dart';

class SetCheckBoxUseCase extends BaseUseCase<dynamic> {
  late UserListRepository _userListRepository;

  SetCheckBoxUseCase(UserListRepository userListRepository) {
    this._userListRepository = userListRepository;
  }

  @override
  Future<List<UserListModel>> perform([onChanged,userlist,index]) {
    return _userListRepository.setcheckbox(onChanged,userlist,index);
  }
}
