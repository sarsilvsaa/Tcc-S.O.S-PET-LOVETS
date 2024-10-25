import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String uid;
  final String email;
  final String bio;
  final String cidade;
  final String photoUrl;

  const User({
    required this.email,
    required this.photoUrl,
    required this.uid,
    required this.cidade,
    required this.bio,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'email': email,
        'cidade': cidade,
        'bio': bio,
        'photoUrl': photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot['email'],
        photoUrl: snapshot['photoUrl'],
        uid: snapshot['uid'],
        cidade: snapshot['cidade   '],
        bio: snapshot['bio'],
        name: snapshot['name']);
  }
}
