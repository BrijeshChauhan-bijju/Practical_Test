import 'package:testproject/domain/repository/userlist_repository.dart';
import 'package:testproject/domain/model/user_domain.dart';
import 'package:testproject/domain/usecase/base_usecase.dart';
import 'package:testproject/presentation/model/user_item.dart';

class GlobalCheckBoxUseCase extends BaseUseCase<dynamic> {
  late UserListRepository _userListRepository;

  GlobalCheckBoxUseCase(UserListRepository userListRepository) {
    this._userListRepository = userListRepository;
  }

  @override
  Future<List<UserItem>> perform() async{
    List<UserDomain> _list =  await _userListRepository.globalcheck();
    return _list.mapToPresentationList();
  }
}
