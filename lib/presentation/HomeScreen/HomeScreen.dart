import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testproject/presentation/AllUserScreen/AllUserListScreen.dart';
import 'package:testproject/presentation/HomeScreen/BottomNavigatonBarProvider.dart';
import 'package:testproject/presentation/SelectedUserScreen/SelectedUserScreen.dart';
import 'package:testproject/utils/AppColors.dart';
import 'package:testproject/utils/UniversalClass.dart';

class HomeScreen extends StatefulWidget {
  static const String TAG = "/homescreen";

  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  GlobalKey<AllUserListScreenState> _alluserscreen =
      new GlobalKey<AllUserListScreenState>();
  GlobalKey<SelectedUserScreenState> _selecteduserscreen =
      new GlobalKey<SelectedUserScreenState>();
  // late BottomNavigationBarProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(builder: (context, model, child) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Scaffold(
            body: IndexedStack(
              index: model.currentIndex,
              children: [
                AllUserListScreen(
                  key: _alluserscreen,
                ),
                SelectedUserScreen(key: _selecteduserscreen)
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: model.currentIndex,
              unselectedItemColor: Colors.black,
              selectedItemColor: getColorFromHex(AppColors.primaryColor),
              onTap: (index) {
                if (index == 0) {
                  print(index);
                  _alluserscreen.currentState?.provider.updateCheckList();
                } else {
                  _selecteduserscreen.currentState?.provider.fetchdata();
                }
                model.currentIndex = index;
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.supervised_user_circle,
                    size: 20,
                    color: model.currentIndex == 0
                        ? getColorFromHex(AppColors.primaryColor)
                        : Colors.grey,
                  ),
                  label: "All User",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.supervised_user_circle,
                    size: 20,
                    color: model.currentIndex == 1
                        ? getColorFromHex(AppColors.primaryColor)
                        : Colors.grey,
                  ),
                  label: "Selected User",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // provider = Provider.of<BottomNavigationBarProvider>(context);
  }
//
// Widget getPage(int index) {
//   switch (index) {
//     case 0:
//       return AllUserListScreen();
//     case 1:
//       return SelectedUserScreen();
//     default:
//       return AllUserListScreen();
//   }
// }
}
