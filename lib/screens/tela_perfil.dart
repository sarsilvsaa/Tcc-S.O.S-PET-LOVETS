import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/screens/tela_ajustes.dart';
import 'package:teste/screens/tela_inicial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste/screens/bd/user.dart';
import 'package:teste/screens/resources/auth.dart';
import 'package:teste/widgtes/until.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  var userData = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);

    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 15),
                  Text(
                    'Meu Perfil',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      color: appTheme.modoNoturno
                          ? Color(0xffffffff)
                          : Color(0xffA45309),
                    ),
                  ),
                ],
              ),
              Divider(
                color: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xffA45309),
                thickness: 4,
                indent: 15,
                endIndent: 15,
              ),
              SizedBox(height: 10),
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
                backgroundImage: NetworkImage(
                    userData['photoUrl'] ?? 'https://via.placeholder.com/150'),
                // Adicione esta linha
              ),
              const SizedBox(height: 16),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${userData['name'] ?? 'Nome não disponível'}',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Pangolin',
                      color: appTheme.modoNoturno
                          ? Color(0xffffffff)
                          : Color(0xffa45309),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 300,
                height: 200,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appTheme.modoNoturno
                      ? Color(0xb9b94f4f)
                      : Color.fromRGBO(144, 89, 89, 0.26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Biografia: ${userData['bio'] ?? 'Biografia não disponível'}', // Adicione esta linha
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Pangolin',
                      color: appTheme.modoNoturno
                          ? Color(0xffffffff)
                          : Color(0xbfa45309),
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 100,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appTheme.modoNoturno
                      ? Color(0xb9b94f4f)
                      : Color.fromRGBO(144, 89, 89, 0.26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Minha cidade: ${userData['cidade'] ?? 'Cidade não disponível'}', // Adicione esta linha
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Pangolin',
                      color: appTheme.modoNoturno
                          ? Color(0xffffffff)
                          : Color(0xbfa45309),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
