import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/data/remote/repository/UserListRepository.dart';
import 'package:testproject/domain/BaseUseCase.dart';

class GetDatFromSharedPref extends BaseUseCase<dynamic> {
  late UserListRepository _userListRepository;

  GetDatFromSharedPref(UserListRepository userListRepository) {
    this._userListRepository = userListRepository;
  }

  @override
  Future<List<UserListModel>> perform([userlist]) async{
    return  _userListRepository.getfromshared(userlist);
  }
}
