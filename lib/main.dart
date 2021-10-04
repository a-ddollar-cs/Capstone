import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capstone_proj/Splash_Page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: "LandBuddy",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //home: Home(),
      home: FirstView(),
      routes: <String, WidgetBuilder> {
        '/signup': (BuildContext context) => FirstView(),
        '/home': (BuildContext context) => FirstView(),
        '/login': (BuildContext context) => FirstView(),
      }
    );
  }
}