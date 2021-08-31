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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child:  SafeArea(
            child: Scaffold(
              body: getPage(provider.currentIndex),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.currentIndex,
                unselectedItemColor: Colors.black,
                selectedItemColor: getColorFromHex(AppColors.primaryColor),
                onTap: (index) {
                  provider.currentIndex = index;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.supervised_user_circle,
                      size: 20,
                      color: provider.currentIndex == 0
                          ? getColorFromHex(AppColors.primaryColor)
                          : Colors.grey,
                    ),
                    label: "All User",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.supervised_user_circle,
                      size: 20,
                      color: provider.currentIndex == 1
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
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return AllUserListScreen();
      case 1:
        return SelectedUserScreen();
      default:
        return AllUserListScreen();
    }
  }
}
