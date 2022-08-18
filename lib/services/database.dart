import 'dart:math';
import 'package:cat_holder/models/cat.dart';
import 'package:cat_holder/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/*
  This is the pseudo database used for the assessment.
  It contains cat information for the cards as well as user information.
  It also provides a pseudo-authentication method for the sake of demonstration
*/

class CatHolderDatabase extends ChangeNotifier {
  // The following streams are used for fetching cat data from Firestore
  static Stream<QuerySnapshot> allCatsStream =
      FirebaseFirestore.instance.collection('cats').snapshots();
  static Stream<QuerySnapshot> featureCatsStream = FirebaseFirestore.instance
      .collection('cats')
      .where('featured', isEqualTo: true)
      .snapshots();

  User? loggedInUser;
  List<Cat> allCats = [];

  List<Cat> featuredCats = [];

  // This method enables the current user to log in and return its auth credentials
  AuthCredentials? logIn(User user) {
    loggedInUser = user;
    notifyListeners();
    return AuthCredentials();
  }

  // Revokes user login
  void logOut() {
    loggedInUser!.credentials = null;
    loggedInUser = null;
    notifyListeners();
  }
}

/*
  This is just a minimal authentication credential class to be used by the 
  main database to simulate a user login
*/

class AuthCredentials {
  AuthCredentials() {
    issuedDate = DateTime.now();
    expiryDate = issuedDate.add(const Duration(days: 1));
    uid = Random().toString();
  }
  late DateTime issuedDate;
  late DateTime expiryDate;
  late String uid;
}
