import 'package:chatting/signin/authclass.dart';
import 'package:chatting/signin/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<BaseAuth>(
      create: (context) => Auth(),
      child: MaterialApp(
          title: 'DoorStep Security',
          theme: ThemeData(
            primaryColor: Colors.indigo[700],
            accentColor: Colors.indigo,
            backgroundColor: Colors.indigo[100],      //change here to change all the background color of each page
            cardColor: Colors.indigo[100],             //change here to change all the card color of each page
          ),
          darkTheme: ThemeData.dark(),                 //dark theme
          debugShowCheckedModeBanner: false,            //remove the debug banner while in debug mode
          home: LandingPage()),
    );
  }
}
