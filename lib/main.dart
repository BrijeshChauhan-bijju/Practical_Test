import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testproject/presentation/AllUserScreen/AllUserListProvider.dart';
import 'package:testproject/presentation/HomeScreen/BottomNavigatonBarProvider.dart';
import 'package:testproject/presentation/HomeScreen/HomeScreen.dart';
import 'package:testproject/presentation/SelectedUserScreen/SelectedUserProvider.dart';
import 'package:testproject/utils/memory_management.dart';

void main() {
  ///for check life cycle
  WidgetsFlutterBinding.ensureInitialized();
  MemoryManagement.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (context) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider<AllUserListProvider>(
          create: (context) => AllUserListProvider(),
        ),
        ChangeNotifierProvider<SelectedUserProvider>(
          create: (context) => SelectedUserProvider(),
        ),
      ], child: MyApp()),
    );
  });
}

class MyApp extends StatefulWidget {
  MyApp();

  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  MyAppState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {'/': (context) => HomeScreen()});
  }
}
