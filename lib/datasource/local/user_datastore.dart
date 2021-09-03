import 'dart:convert';
import 'package:testproject/datasource/local/memory_management.dart';
import 'package:testproject/domain/model/user_domain.dart';

class Userdatastore {
  ///list of user from shared preferences
  Future<List<UserDomain>> getfromshared() async {
    List<UserDomain> userlist = [];
    if (MemoryManagement.getuserlist() != null) {
      var sharedpreflist =
          await jsonDecode(MemoryManagement.getuserlist().toString());
      sharedpreflist.forEach((element) {
        UserDomain postEntity = UserDomain.fromJson(element);
        userlist.add(postEntity);
      });
    }

    print("userlist=>,${userlist}");
    return userlist;
  }

  savetoshared(List<UserDomain> checkeduserlist) {
    var userlistvalue = json.encode(checkeduserlist);
    MemoryManagement.setuserlist(userlist: userlistvalue);
  }

  void clear() {
    MemoryManagement.clearMemory();
  }
}
