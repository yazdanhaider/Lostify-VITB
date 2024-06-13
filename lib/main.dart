import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Lostify/firebase_options.dart';
import 'package:Lostify/login_verification.dart';
import 'package:Lostify/pages/more_page.dart';
import 'package:Lostify/theme/dark_theme.dart';
import 'package:Lostify/theme/default_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'backend/login_details.dart';

ThemeData themeData = lightThemeData;
// ColorScheme colorScheme = lightColorScheme;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isUserLoggedIn = prefs.getBool('isUserLoggedIn') ?? false;
  getLoginDetails();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // themeData = Theme.of(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ValueListenableBuilder(
        valueListenable: forceLightTheme,
        builder: (context, value, child) {
          return MaterialApp(
            theme: lightThemeData,
            darkTheme: darkThemeData,
            themeMode: value ? ThemeMode.light : ThemeMode.system,
            // home: isUserLoggedIn ? const Layout() : const LoginPage(),
            home: const LoginVerification(),
          );
        });
  }
}
