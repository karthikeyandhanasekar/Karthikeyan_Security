import 'package:doorstep_resident/database/database.dart';
import 'package:doorstep_resident/firestore.dart';
import 'package:doorstep_resident/show.dart';
import 'package:doorstep_resident/signin/singin.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'authclass.dart';

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
                create: (_) => FirestoreDatabase(
                    email: emailcontrollers.text,
                    blockid: blockcontroller.text.trim()),
                child: Show(),
              );
            }
          } else {
            return Scaffold(
              body: Center(
                child: Center(child: LoadingBouncingGrid.circle()),
              ),
            );
          }
        });
  }
}
