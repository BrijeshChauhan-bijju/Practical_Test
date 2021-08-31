import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/data/model/user_list_model.dart';
import 'package:testproject/presentation/AllUserScreen/AllUserListProvider.dart';
import 'package:testproject/utils/UniversalClass.dart';

class AllUserListScreen extends StatefulWidget {
  AllUserListScreen();

  @override
  AllUserListScreenState createState() => AllUserListScreenState();
}

class AllUserListScreenState extends State<AllUserListScreen> {
  late AllUserListProvider provider;
  List<UserListModel> _userlistmodel = [];
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(milliseconds: 100)).then((value) {
      fetchdata(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllUserListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("All Users List"),
      ),
      body: provider.isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : builduserlist(provider.userlist),
    );
  }

  Widget builduserlist(List<dynamic> userlist) {
    if (_userlistmodel.isEmpty) {
      return Center(
        child: Text("Some thing went wrong"),
      );
    } else {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroll) {
            if (provider.isdataloaded == false &&
                scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
              currentPage++;
              fetchdata(currentPage);
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
                  return GestureDetector(
                    onLongPress: () {},
                    child: Container(
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
                                provider.setcheckbox(onChanged, index);
                              })
                        ],
                      ),
                    ),
                  );
                }),
          ));
    }
  }

  void fetchdata(int currentPage) async {
    if (provider.isdataloaded == false) {
      provider.getAllUserList((context), (userlistdata) {
        _userlistmodel.addAll(userlistdata);
      }, (error) {
        print(error);
      });
    }
  }
}
