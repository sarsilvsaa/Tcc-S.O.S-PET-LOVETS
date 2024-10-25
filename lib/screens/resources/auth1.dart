import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:teste/screens/bd/user1.dart' as model;
import 'package:teste/screens/resources/storage_methods.dart';

class AuthMethods1 {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User1> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore
        .collection('users-caregivers')
        .doc(currentUser.uid)
        .get();

    return model.User1.fromSnap(snap);
  }

  Future<String> signUpUserWithEmailAndPassword1({
    required String email,
    required String password,
    required String name,
    required String cidade,
    required String telefone,
    required String porte,
    required String dist,
    required String expOra,
    required String expInj,
    required String expVet,
    required String controller,
    required String disponilibidade,
    required String redesocial,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Erro.";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          telefone.isNotEmpty &&
          redesocial.isNotEmpty &&
          dist.isNotEmpty &&
          expInj.isNotEmpty &&
          expOra.isNotEmpty &&
          expVet.isNotEmpty &&
          controller.isNotEmpty &&
          disponilibidade.isNotEmpty &&
          porte.isNotEmpty &&
          cidade.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User1 user = model.User1(
          email: email,
          photoUrl: photoUrl,
          uid: cred.user!.uid,
          controller: controller,
          porte: porte,
          expInj: expInj,
          expOra: expOra,
          expVet: expVet,
          dist: dist,
          bio: bio,
          disponibilidade: disponilibidade,
          telefone: telefone,
          cidade: cidade,
          redesocial: redesocial,
          name: name,
        );

        await _firestore.collection('users-caregivers').doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = "Sucesso.";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
