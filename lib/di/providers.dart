import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:testproject/datasource/local/memory_management.dart';
import 'package:testproject/datasource/remote/UserListApi/userlist_api.dart';
import 'package:testproject/datasource/remote/UserListApi/userlist_apiImpl.dart';
import 'package:testproject/datasource/remote/request/user_request.dart';
import 'package:testproject/domain/repository/userlist_repository.dart';
import 'package:testproject/domain/repository/userlist_repositoryimpl.dart';
import 'package:testproject/domain/usecase/SetCheckBoxUseCase.dart';
import 'package:testproject/domain/usecase/UpdateListUseCase.dart';
import 'package:testproject/domain/usecase/UserListUseCase.dart';
import 'package:testproject/domain/usecase/globalcheck_usecase.dart';
import 'package:testproject/domain/usecase/selecteduser_usecase.dart';
import 'package:testproject/domain/usecase/sharedpref_usecase.dart';
import 'package:testproject/presentation/AllUserScreen/alluserviewmodel.dart';
import 'package:testproject/presentation/HomeScreen/tabbarviewmodel.dart';
import 'package:testproject/presentation/SelectedUserScreen/selecteduserviewmodel.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  // Provider(create: (_) => MemoryManagement()),
  ChangeNotifierProvider(create: (context) => TabBarViewModel()),
  Provider(create: (_) => UserRequest()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<UserRequest, UserListApi>(
    update: (context, userrequest, postRequest) => UserListApiImpl(userrequest),
  ),
  ProxyProvider<UserListApi, UserListRepository>(
    update: (context, userlistapi, postRequest) =>
        UserListRepositoryImpl(userlistapi),
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
