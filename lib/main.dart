import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

const SENTRY_CODE = 'assets/sentry_code.txt';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);
  String sentryCode = await rootBundle.loadString(SENTRY_CODE);
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await SentryFlutter.init(
    (options) => options.dsn = sentryCode,
    appRunner: () => runApp(MyApp(
      preferences: preferences,
    )),
  );
}
