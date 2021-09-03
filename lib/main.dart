import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testproject/di/providers.dart';
import 'package:testproject/presentation/HomeScreen/TabBarScreen.dart';
import 'package:testproject/datasource/local/memory_management.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MemoryManagement.init();
  runApp(MultiProvider(providers: providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {'/': (context) => TabBarScreen()});
  }
}
