import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User {                      //This class get User unique id(uid)
  User({@required this.uid});
  final String uid;
}

abstract class BaseAuth {                                            //Abstract class contain all the methods
  Future<User> signin(String email, String password);
  Future<User> signup(String email, String password);
  Future<void> signout();
  Future<User> CurrentUser();
  Stream<User> get onAuthStateChanged;
}

class Auth implements BaseAuth {
  User _userfromfirebase(FirebaseUser user) {                        //it check whether the uid is null or not
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }
 
  // IT a stream which check the user is login or not
  Stream<User> get onAuthStateChanged {                                                               
    return FirebaseAuth.instance.onAuthStateChanged.map(_userfromfirebase);
  }
   
  //siginin  the exisiting user
  Future<User> signin(String email, String password) async {
    AuthResult result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userfromfirebase(user);
  }
   //create a new user
  Future<User> signup(String email, String password) async {
    AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userfromfirebase(user);
  }
   
//check the current user
  Future<User> CurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return _userfromfirebase(user);
  }
  //signinout

  Future<void> signout() async {
    FirebaseAuth.instance.signOut();
  }
}
