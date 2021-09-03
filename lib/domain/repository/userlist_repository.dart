import 'package:testproject/domain/model/user_domain.dart';
import 'package:testproject/presentation/model/user_item.dart';

abstract class UserListRepository {
  Future<List<UserDomain>> getUserList(int currentPage, int perpage);

  Future<List<UserDomain>> setcheckbox(
      bool onChanged, UserItem useritem);

  Future<List<UserDomain>> updatelist();

  Future<List<UserDomain>> updateselectedusercheckbox(bool onChanged,UserItem useritem);
  List<UserDomain> globalcheck();
  Future<List<UserDomain>> getfromshared();
}
