import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snemovna/navigation/Navigation.dart';
import 'package:snemovna/screen/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'MySnemovna',
      routes: Navigation.me.routeList(),
      navigatorKey: Navigation.me.navigatorKey,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(barIndex: 0),
      onGenerateRoute: Navigation.me.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
