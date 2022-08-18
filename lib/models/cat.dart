import 'package:flutter/material.dart';

class Cat {
  // Generic constructor
  Cat({
    required this.name,
    required this.description,
    required this.imageAssetName,
  });

  // The cat's name
  String name;

  // The cat's description
  String description;

  // The cat's picture url (so you don't have to store it locally)
  String imageAssetName;
}
