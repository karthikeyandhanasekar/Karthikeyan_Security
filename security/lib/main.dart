import 'package:chatting/database/database.dart';
import 'package:chatting/sample.dart';
import 'package:chatting/signin/authclass.dart';
import 'package:chatting/signin/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
                               // now adding the remainder feature
class MyApp extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        Provider<BaseAuth>( create: (_) => Auth(),),
        Provider<Database>(create: (_) => FirestoreDatabase( uid: null),)
      ] ,
          child: MaterialApp(
              title: 'DoorStep Security',
              /*theme: ThemeData(
                primaryColor: Colors.indigo[700],
                accentColor: Colors.indigo,
                //backgroundColor: Colors.indigo[100],       //change background color
                cardColor: Colors.indigo[100],               //change cardcolor
              ),*/
              darkTheme: ThemeData.dark(),
              debugShowCheckedModeBanner: true,    // check banner is true
            home: LandingPage()
              //home: sample(),
              
              
              ),
    );
  }
}
