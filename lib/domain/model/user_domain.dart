import 'package:testproject/data/entity/user_entity.dart';
import 'package:testproject/presentation/model/user_item.dart';

class UserDomain {
  String? login;
  int? id;
  String? avatarUrl;
  bool? ischecked;

  UserDomain({this.login, this.id, this.avatarUrl, this.ischecked});

  UserDomain.fromJson(dynamic json) {
    login = json['login'];
    id = json['id'];
    avatarUrl = json['avatar_url'];
    ischecked = json['ischecked'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['login'] = login;
    map['id'] = id;
    map['avatar_url'] = avatarUrl;
    map['ischecked'] = ischecked;
    return map;
  }
}

extension UserEntityExt on UserEntity {
  UserDomain mapToDomain() => UserDomain(
        id: this.id,
        login: this.login,
        avatarUrl: this.avatarUrl,
        ischecked: this.ischecked,
      );
}

extension UserEntityListExt on List<UserEntity> {
  List<UserDomain> maptoDomainList() =>
      this.map((element) => element.mapToDomain()).toList();
}