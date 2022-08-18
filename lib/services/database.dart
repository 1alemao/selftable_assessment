import 'dart:math';
import 'package:cat_holder/models/cat.dart';
import 'package:cat_holder/models/user.dart';
import 'package:flutter/material.dart';

/*
  This is the pseudo database used for the assessment.
  It contains cat information for the cards as well as user information.
  It also provides a pseudo-authentication method for the sake of demonstration
*/

class CatHolderDatabase extends ChangeNotifier {
  CatHolderDatabase() {
    allCats = [
      Cat(
        name: 'Awesome cat',
        description: 'very nice cat with cute ears',
        imageAssetName: "assets/awesome_cat.png",
      ),
      Cat(
        name: 'Regular cat',
        description: 'regular cat with regular ears',
        imageAssetName: "assets/regular_cat.jpg",
      ),
      Cat(
        name: 'Bad cat',
        description: 'not an exemplary cat',
        imageAssetName: "assets/bad_cat.jpeg",
      ),
      Cat(
        name: 'Not a cat',
        description: 'this is definitely not a cat',
        imageAssetName: "assets/not_a_cat.jpg",
      ),
      Cat(
        name: 'Cursed cat',
        description: 'you tell me what the hell is this',
        imageAssetName: "assets/cursed_cat.jpeg",
      ),
    ];
    featuredCats = [
      allCats[3],
      allCats[4],
    ];
  }
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
