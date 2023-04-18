import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
// import '../models/user.dart' ;

class Database {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final usercollection = FirebaseFirestore.instance.collection("usertable");

// create user object based on firebase user
  Myuser _userFromFirebaseUser(User? user, Myuser? det) {
    Myuser retUser = Myuser(id: user!.uid);

    return retUser;
  }

  //auth change user stream
  Stream<Myuser> get userchanges {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user, null));
  }

  // sign in with email and password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!, null);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // register
  Future register(Myuser newuser) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: newuser.email!, password: newuser.password!);
      User? user = result.user;

      //creat new user record with details
      await writeUserData(newuser, user!.uid);

      return _userFromFirebaseUser(user, newuser);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future writeUserData(Myuser user, String uid) async {
    return await usercollection.doc(uid).set({
      "name": user.name,
      "bloodgroup": user.bloodgroup,
      "location": user.location,
      "phone": user.phone,
    });
  }
}
