import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/repository/UserListRepository.dart';
import 'package:testproject/domain/BaseUseCase.dart';

class SelectedUserCheckBoxUseCase extends BaseUseCase<dynamic> {
  late UserListRepository _userListRepository;

  SelectedUserCheckBoxUseCase(UserListRepository userListRepository) {
    this._userListRepository = userListRepository;
  }

  @override
  Future<List<UserListModel>> perform([onChanged,userlist,index]) async{
    return await _userListRepository.updateselectedusercheckbox(onChanged,userlist,index);
  }
}
