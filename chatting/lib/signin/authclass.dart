import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class User
{
  User({@required this.uid});
  final  String uid;

}



abstract class BaseAuth{
  Future<User> signin(String email, String password);
    Future<User> signup(String email, String password);
  Future<void> signout();
  Future<User> CurrentUser();
  Stream<User> get onAuthStateChanged;

}

class Auth implements BaseAuth{
  User _userfromfirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
        uid: user.uid);
  }
  Stream<User> get onAuthStateChanged
  {
    return FirebaseAuth.instance.onAuthStateChanged.map(_userfromfirebase);
  }
  
  
  
  
  
    
   
    
  
    Future<User> signin(String email, String password) async
    {
      AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
      return _userfromfirebase(user);
      
      
  
    }
    
    Future<User> signup(String email, String password)async{
      AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromfirebase(user);
      
    }  
    Future<User> CurrentUser() async{
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
       return _userfromfirebase(user);
     }
    Future<void> signout() async
    {
       FirebaseAuth.instance.signOut();
    }
  }
  
 
