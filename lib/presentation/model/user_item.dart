import 'package:testproject/domain/model/user_domain.dart';

class UserItem {
  String? login;
  int? id;
  String? avatarUrl;
  bool? ischecked;

  UserItem({
      this.login, 
      this.id, 
      this.avatarUrl, 
      this.ischecked});
}

extension UserDomainExt on UserDomain {
  UserItem mapToPresentation() => UserItem(
    id: this.id,
    login: this.login,
    avatarUrl: this.avatarUrl,
    ischecked: this.ischecked,
  );
}

extension UserDomainListExt on List<UserDomain> {
  List<UserItem> mapToPresentationList() =>
      this.map((element) => element.mapToPresentation()).toList();
}

