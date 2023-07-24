import 'package:c_sok/Welcome.dart';
import 'package:c_sok/dashboard.dart';
import 'package:c_sok/groupe/groupe_action.dart';
import 'package:c_sok/groupe/groupe_list.dart';
import 'package:c_sok/settings.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*return MaterialApp(
      title: 'C-SOK',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Welcome(),
        '/dashboard': (context) => Dashboard(),
        '/settings': (context) => Settings()
      },
  
      theme: ThemeData(
        primarySwatch: Colors.blueGrey     ,
      ),
      //home: const MyHomePage(title: 'C-SOK'),
    );*/
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.white,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        //primarySwatch: Colors.amber,
        primaryColor: Colors.black,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'C-SOk',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Dashboard(), //Welcome(),
          '/dashboard': (context) => const Dashboard(),
          '/settings': (context) => const Settings(),
          '/groupes': (context) => const GroupeList(),
        },
        theme: theme,
      ),
    );
  }
}
