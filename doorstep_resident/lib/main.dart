//import 'dart:async';

import 'package:doorstep_resident/database/database.dart';
import 'package:doorstep_resident/signin/authclass.dart';
import 'package:doorstep_resident/signin/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doorstep_resident/signin/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<BaseAuth>(
        create: (_) => Auth(),
        child: Provider<Database>(
          create: (_) =>
              FirestoreDatabase(email: emailcontroller.text, blockid: null),
          child: MaterialApp(
              title: 'DoorStep Resident',
              theme: ThemeData(
                primaryColor: Colors.indigo[700],
                accentColor: Colors.indigo,
                backgroundColor: Colors.indigo[100],
                cardColor: Colors.indigo[100],
              ),
              darkTheme: ThemeData.dark(),
              debugShowCheckedModeBanner: false,
              home: LandingPage()),
        ));
  }
}
