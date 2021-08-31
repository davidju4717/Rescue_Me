import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'screens/post_list_screen.dart';

class MyApp extends StatefulWidget {
  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    final sentryId =
        await Sentry.captureException(error, stackTrace: stackTrace);
  }

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  final SharedPreferences preferences;

  const MyApp({required this.preferences});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late ThemeBrightness themeBrightness;

  void initState() {
    super.initState();
    initThemeBrightneses();
  }

  void initThemeBrightneses() {
    setState(() {
      if (widget.preferences.getBool('isDark') == true) {
        themeBrightness = ThemeBrightness(true);
      } else {
        themeBrightness = ThemeBrightness(false);
      }
    });
  }

  void updateDarkBrightness() {
    setState(() {
      themeBrightness.changeDarkBrightness();
    });
    widget.preferences.setBool('isDark', themeBrightness.isDark);
  }

  void updateLightBrightness() {
    setState(() {
      themeBrightness.changeLightBrightness();
    });
    widget.preferences.setBool('isDark', themeBrightness.isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rescue Me!',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        canvasColor:
            themeBrightness.isDark ? Colors.grey[850] : Colors.lightGreen[100],
        brightness: themeBrightness.isDark ? Brightness.dark: Brightness.light,
        fontFamily: 'DancingScript',
      ),
      navigatorObservers: <NavigatorObserver>[MyApp.observer],
      home: PostListScreen(
        analytics: MyApp.analytics,
      ),
    );
  }
}

class ThemeBrightness {
  bool dark;

  ThemeBrightness(this.dark);

  bool get isDark => dark;

  void changeLightBrightness() {
    dark = false;
  }

  void changeDarkBrightness() {
    dark = true;
  }
}
