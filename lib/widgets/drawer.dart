import 'package:flutter/material.dart';
import 'dark_mode.dart';

Widget drawer() {
  return Drawer(
      child: ListView(children: [
        Container(
          height: 70,
          child: const DrawerHeader(
            child: Text("Settings",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ),
        DarkMode(),
  ]));
}
