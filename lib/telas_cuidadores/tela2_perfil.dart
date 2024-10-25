import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/screens/tela_ajustes.dart';
import 'package:teste/screens/tela_inicial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste/screens/bd/user.dart';
import 'package:teste/widgtes/until.dart';
import 'package:teste/screens/resources/auth.dart';

class ProfileCuidadorUserScreen extends StatefulWidget {
  final String uid;
  const ProfileCuidadorUserScreen({Key? key, required this.uid})
      : super(key: key);

  @override
  State<ProfileCuidadorUserScreen> createState() =>
      _ProfileCuidadorUserScreenState();
}

class _ProfileCuidadorUserScreenState extends State<ProfileCuidadorUserScreen> {
  bool isLoading = false;
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
          .collection('users-caregivers')
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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:
                  appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 60,
                  backgroundImage: NetworkImage(userData['photoUrl']),
                ),
                const SizedBox(height: 10),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${userData['name']} \n ${userData['cidade'] ?? ''}',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'WorkSans',
                        color: appTheme.modoNoturno
                            ? Color(0xffffffff)
                            : Color.fromARGB(255, 15, 15, 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pets,
                          color: appTheme.modoNoturno
                              ? Color(0xffffffff)
                              : Color.fromARGB(190, 0, 0, 0),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'DISPONIBILIDADE: \n ${userData['disponibilidade'] ?? 'Não informado'}',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Pangolin',
                            color: appTheme.modoNoturno
                                ? Color(0xffffffff)
                                : Color.fromARGB(190, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color.fromARGB(255, 0, 0, 0),
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pets,
                          color: appTheme.modoNoturno
                              ? Color(0xffffffff)
                              : Color.fromARGB(190, 0, 0, 0),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'PREFERÊNCIAS:\n'
                          'Possui experiência com medicações orais?: ${userData['expOra'] ?? 'Não informado'}\n'
                          'Possui experiência com medicações injetáveis?: ${userData['expInj'] ?? 'Não informado'}\n'
                          'Possui experiência com atendimento veterinário?: ${userData['expVet'] ?? 'Não informado'}',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Pangolin',
                            color: appTheme.modoNoturno
                                ? Color(0xffffffff)
                                : Color.fromARGB(190, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color.fromARGB(255, 0, 0, 0),
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pets,
                          color: appTheme.modoNoturno
                              ? Color(0xffffffff)
                              : Color.fromARGB(190, 0, 0, 0),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'ATÉ QUAL PORTE ATENDE: \n ${userData['porte'] ?? 'Não informado'}',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Pangolin',
                            color: appTheme.modoNoturno
                                ? Color(0xffffffff)
                                : Color.fromARGB(190, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color.fromARGB(255, 0, 0, 0),
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pets,
                          color: appTheme.modoNoturno
                              ? Color(0xffffffff)
                              : Color.fromARGB(190, 0, 0, 0),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'PODE ATENDER EM ATÉ: \n ${userData['dist'] != null ? '${userData['dist']} metros/km' : 'Não informado'}',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Pangolin',
                            color: appTheme.modoNoturno
                                ? Color(0xffffffff)
                                : Color.fromARGB(190, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color.fromARGB(255, 0, 0, 0),
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pets,
                          color: appTheme.modoNoturno
                              ? Color(0xffffffff)
                              : Color.fromARGB(190, 0, 0, 0),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'CONTATO:\n ${userData['redesocial'] ?? 'Não informado'} \n ${userData['telefone']}',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Pangolin',
                            color: appTheme.modoNoturno
                                ? Color(0xffffffff)
                                : Color.fromARGB(190, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color.fromARGB(255, 0, 0, 0),
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                const SizedBox(height: 5),
                Container(
                  width: 400,
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
                      'Sobre: \n ${userData['bio'] ?? 'Sem biografia'}',
                      style: TextStyle(
                        fontSize: 15,
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
      ),
    );
  }
}
