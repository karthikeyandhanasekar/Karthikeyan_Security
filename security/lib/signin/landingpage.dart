import 'package:chatting/database/database.dart';
import 'package:chatting/firestore.dart';
import 'package:chatting/show.dart';
import 'package:chatting/signin/singin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authclass.dart';
import 'package:loading_animations/loading_animations.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<BaseAuth>(context);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return Signin();
            } else {
              return Provider<Database>(
                create: (_) => FirestoreDatabase(uid: user.uid),
                //child: Details(),);
                child:  Show()
              );
            }
          } else {
            return Scaffold(
              body: Center(child: LoadingBouncingGrid.circle()),
            );
          }
        });
  }
}
