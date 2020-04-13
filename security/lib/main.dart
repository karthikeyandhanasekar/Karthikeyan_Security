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
            backgroundColor: Colors.indigo[100],
            cardColor: Colors.indigo[100],
          ),
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: LandingPage()),
    );
  }
}
