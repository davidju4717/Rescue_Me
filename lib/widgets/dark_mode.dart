import 'package:flutter/material.dart';
import '../app.dart';

class DarkMode extends StatefulWidget {
  const DarkMode({Key? key}) : super(key: key);
  @override
  _DarkModeState createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    MyAppState? appState = context.findAncestorStateOfType<MyAppState>();
    bool _dark = appState!.themeBrightness.isDark;

    return SwitchListTile(
        title: const Text('Dark mode',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        value: _dark,
        onChanged: (newValue) {
          setState(() {
            _dark = newValue;
            if (_dark) {
              appState.updateDarkBrightness();
            } else {
              appState.updateLightBrightness();
            }
          });
        });
  }
}
