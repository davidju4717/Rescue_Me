import 'package:flutter/material.dart';
import 'screens/waste_list_screen.dart';
import 'screens/waste_detail_screen.dart';
import 'screens/new_waste_screen.dart';


class MyApp extends StatelessWidget {

  static final Map<String, Widget Function(BuildContext)> routes = {
    WasteListScreen.routeName: (context) => WasteListScreen(),
  };


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WasteListScreen(),
      // routes: MyApp.routes,
    );
  }
}