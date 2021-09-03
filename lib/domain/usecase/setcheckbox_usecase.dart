import 'package:testproject/domain/repository/userlist_repository.dart';
import 'package:testproject/domain/model/user_domain.dart';
import 'package:testproject/domain/usecase/base_usecase.dart';
import 'package:testproject/presentation/model/user_item.dart';

class SetCheckBoxUseCase extends BaseUseCase<dynamic> {
  late UserListRepository _userListRepository;

  SetCheckBoxUseCase(UserListRepository userListRepository) {
    this._userListRepository = userListRepository;
  }

  @override
  Future<List<UserItem>> perform([onChanged, useritem]) async {
    List<UserDomain> _list =
        await _userListRepository.setcheckbox(onChanged, useritem);
    return _list.mapToPresentationList();
  }
}
