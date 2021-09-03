
import 'package:testproject/domain/model/user_domain.dart';

abstract class UserListApi{
  Future<List<UserDomain>> getuserlist(int currentPage,int perpage);
}