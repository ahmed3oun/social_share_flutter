import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_share/pages/home.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Social Share",
      theme: ThemeData(primaryColor: Colors.purple, accentColor: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
