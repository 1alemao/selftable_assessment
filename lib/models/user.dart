import 'package:cat_holder/models/cat.dart';
import 'package:cat_holder/services/database.dart';
import 'package:flutter/material.dart';

/*
  This is the User representaion model containing its name, birthday, pictureUrl
  liked cats list and credentials for simulating login
*/

class User extends ChangeNotifier {
  // Generic User constructor
  User({
    this.name,
    this.birthday,
    this.pictureUrl,
  });

  // The user's name/alias
  String? name;

  // The user's birthday (to extract it's age)
  DateTime? birthday;

  // The user's picture URL (so it doesn't have to be stored locally)
  String? pictureUrl;

  // This list holds the user's liked cats
  List<Cat> likedCats = [];

  // For authentication simulation
  AuthCredentials? credentials;

  // Adds a cat to the user's list and notifies the listeners
  void addCat(Cat cat) {
    likedCats.add(cat);
    notifyListeners();
  }

  // Removes a cat to the user's list and notifies the listeners
  void removeCat(Cat cat) {
    likedCats.remove(cat);
    notifyListeners();
  }

  // Simulates authentication
  void authenticate(AuthCredentials? credentials) {
    if (credentials != null) {
      this.credentials = credentials;
      notifyListeners();
    }
  }

  // Returns true if user has valid authentication credentials
  bool isAuthenticated() => credentials != null;
}
