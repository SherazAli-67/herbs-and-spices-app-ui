import 'package:flutter/material.dart';
import 'package:herbs_and_spices_app/constants/string_const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .light
      ),
      home: Scaffold(body: Center(child: Text("Herbs And Spices App UI"),),)
    );
  }
}
