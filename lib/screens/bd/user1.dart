import 'package:cloud_firestore/cloud_firestore.dart';

class User1 {
  final String name;
  final String uid;
  final String email;
  final String bio;
  final String disponibilidade;
  final String photoUrl;
  final String telefone;
  final String cidade;
  final String expInj;
  final String expOra;
  final String expVet;
  final String porte;
  final String dist;
  final String controller;
  final String redesocial;

  const User1({
    required this.email,
    required this.photoUrl,
    required this.uid,
    required this.bio,
    required this.name,
    required this.telefone,
    required this.expVet,
    required this.expInj,
    required this.expOra,
    required this.cidade,
    required this.disponibilidade,
    required this.porte,
    required this.dist,
    required this.controller,
    required this.redesocial,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'email': email,
        'bio': bio,
        'photoUrl': photoUrl,
        'expInj': expInj,
        'expOra': expOra,
        'expVet': expVet,
        'telefone': telefone,
        'cidade': cidade,
        'porte': porte,
        'dist': dist,
        'disponibilidade': disponibilidade,
        'controller': controller,
        'redesocial': redesocial,
      };

  static User1 fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User1(
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      uid: snapshot['uid'],
      bio: snapshot['bio'],
      name: snapshot['name'],
      telefone: snapshot['telefone'],
      cidade: snapshot['cidade'],
      porte: snapshot['porte'],
      expVet: snapshot['expVet'],
      expInj: snapshot['expInj'],
      expOra: snapshot['expOra'],
      disponibilidade: snapshot['disponibilidade'],
      dist: snapshot['dist'],
      controller: snapshot['controller'],
      redesocial: snapshot['redesocial'],
    );
  }
}
