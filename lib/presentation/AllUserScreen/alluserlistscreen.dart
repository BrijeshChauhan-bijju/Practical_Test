import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/presentation/AllUserScreen/alluserviewmodel.dart';
import 'package:testproject/presentation/SelectedUserScreen/SelectedUserScreen.dart';
import 'package:testproject/presentation/model/user_item.dart';
import 'package:testproject/utils/UniversalClass.dart';

class AllUserListScreen extends StatefulWidget {
  AllUserListScreen({required Key key}) : super(key: key);

  @override
  AllUserListScreenState createState() => AllUserListScreenState();
}

class AllUserListScreenState extends State<AllUserListScreen> {
  late AllUserViewModel provider;
  List<UserItem> _userlistmodel = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    provider = AllUserViewModel(
        Provider.of(context), Provider.of(context), Provider.of(context));
    provider.currentPage = 0;
    fetchData(true);
  }

  @override
  Widget build(BuildContext context) {
    print("responselis3445543t=>,${_userlistmodel.length}");
    return ChangeNotifierProvider<AllUserViewModel>(
      create: (_) => provider,
      child: Consumer<AllUserViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("All Users List"),
            ),
            body: provider.isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : builduserlist(),
          );
        },
      ),
    );
  }

  Widget builduserlist() {
    if (_userlistmodel.isEmpty) {
      return Center(
        child: Text(provider.error),
      );
    } else {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroll) {
            if (provider.isdataloaded == false &&
                provider.isdataloading == false &&
                scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
              fetchData(false);
            }
            return true;
          },
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: ListView.builder(
                itemCount: _userlistmodel.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10000.0),
                          child: getCatchenewtworkImage(
                            _userlistmodel[index].avatarUrl!,
                            40,
                            40,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        new Text(
                          _userlistmodel[index].login!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Checkbox(
                            value: _userlistmodel[index].ischecked ?? false,
                            onChanged: (onChanged) {
                              provider.setCheckBox(onChanged, index);
                            })
                      ],
                    ),
                  );
                }),
          ));
    }
  }

  void fetchData(bool isfirst) async {
    var hasinternet = await hasInternetConnection();

    if (hasinternet) {
      if (provider.isdataloaded == false) {
        provider.getAllUserList(isfirst, (userlistdata) {
          _userlistmodel = userlistdata;
          print("responselist=>,${_userlistmodel.length}");
        }, (error) {
          if (error.isNotEmpty)
            provider.error = error;
          else
            provider.error = "No Data Found";
        });
      }
    } else {
      provider.isloading = false;
      provider.error = "Please connect to internet";
    }
  }
}
