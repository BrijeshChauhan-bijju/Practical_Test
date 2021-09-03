import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:testproject/datasource/local/memory_management.dart';
import 'package:testproject/datasource/local/user_datastore.dart';
import 'package:testproject/datasource/remote/UserListApi/userlist_api.dart';
import 'package:testproject/datasource/remote/UserListApi/userlist_apiImpl.dart';
import 'package:testproject/datasource/remote/request/user_request.dart';
import 'package:testproject/domain/repository/userlist_repository.dart';
import 'package:testproject/domain/repository/userlist_repositoryimpl.dart';
import 'package:testproject/domain/usecase/globalcheck_usecase.dart';
import 'package:testproject/domain/usecase/selecteduser_usecase.dart';
import 'package:testproject/domain/usecase/setcheckbox_usecase.dart';
import 'package:testproject/domain/usecase/sharedpref_usecase.dart';
import 'package:testproject/domain/usecase/updatelist_usecase.dart';
import 'package:testproject/domain/usecase/userlist_usecase.dart';
import 'package:testproject/presentation/HomeScreen/tabbar_viewmodel.dart';


List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  // Provider(create: (_) => MemoryManagement()),
  ChangeNotifierProvider(create: (context) => TabBarViewModel()),
  Provider(create: (_) => UserRequest()),
  Provider(create: (_) => Userdatastore()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<UserRequest, UserListApi>(
    update: (context, userrequest, postRequest) => UserListApiImpl(userrequest),
  ),
  ProxyProvider2<UserListApi, Userdatastore, UserListRepository>(
    update: (context, userlistapi, userdatastore, postRequest) =>
        UserListRepositoryImpl(userlistapi, userdatastore),
  ),
  ProxyProvider<UserListRepository, GetDataFromSharedPrefUseCase>(
    update: (context, userlistrepo, datasource) =>
        GetDataFromSharedPrefUseCase(userlistrepo),
  ),
  ProxyProvider<UserListRepository, GlobalCheckBoxUseCase>(
    update: (context, userlistrepo, repository) =>
        GlobalCheckBoxUseCase(userlistrepo),
  ),
  ProxyProvider<UserListRepository, SelectedUserCheckBoxUseCase>(
    update: (context, userlistrepo, repository) =>
        SelectedUserCheckBoxUseCase(userlistrepo),
  ),
  ProxyProvider<UserListRepository, SetCheckBoxUseCase>(
    update: (context, userlistrepo, repository) =>
        SetCheckBoxUseCase(userlistrepo),
  ),
  ProxyProvider<UserListRepository, UpdateListUseCase>(
    update: (context, userlistrepo, repository) =>
        UpdateListUseCase(userlistrepo),
  ),
  ProxyProvider<UserListRepository, UserListUseCase>(
    update: (context, userlistrepo, repository) =>
        UserListUseCase(userlistrepo),
  ),
];
