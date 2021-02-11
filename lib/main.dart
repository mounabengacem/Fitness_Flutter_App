import 'package:flutter/material.dart';
import 'package:new_project/screens/screens.dart';

void main (){
    runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: OnBoardingScreen(),
      theme: ThemeData(
        appBarTheme:AppBarTheme(
          color: Color(0xFF192A56)
        ),
      ),
    );
  }
}