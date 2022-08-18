import 'package:cloud_firestore/cloud_firestore.dart';

class Cat {
  // The cat's name
  late String name;

  // The cat's description
  late String description;

  // The cat's picture url (so you don't have to store it locally)
  late String pictureUrl;

  late bool featured;

  // Custom constructor used to return Cat objects from a DocumentSnapshot
  Cat.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    name = data['name'] ?? 'Failed to load cat name';
    description = data['description'] ?? 'Failed to load cat description';
    pictureUrl = data['pictureUrl'] ??
        "https://thumbs.dreamstime.com/b/error-message-creative-design-48389035.jpg";
    featured = data['featured'] ?? false;
  }

  // Static function for returning a Cat object from a DocumentReference
  static Future<Cat> fromReference(DocumentReference reference) async {
    DocumentSnapshot snapshot = await reference.get();
    return Cat.fromSnapshot(snapshot);
  }
}
