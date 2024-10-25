import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class AppTheme extends ChangeNotifier {
  bool _modoNoturno = false;

  bool get modoNoturno => _modoNoturno;

  void alternarModoNoturno(bool value) {
    _modoNoturno = value;
    notifyListeners();
  }
}

_logout(BuildContext context) {
  FirebaseAuth.instance.signOut().then((result) {
    Navigator.of(context).pushNamedAndRemoveUntil("/decisao", (_) => false);
  });
}

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> deleteuser() {
    return userCollection.doc(uid).delete();
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool?> deleteUser() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await DatabaseService(uid: user.uid).deleteuser();
        await user.delete();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => AppTheme(),
        child: MySettingsPage(),
      ),
    );
  }
}

class MySettingsPage extends StatefulWidget {
  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  Future deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await AuthService().deleteUser();
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/decisao",
          (_) => false,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        title: Text('Ajustes'),
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'SEUS AJUSTES:',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            Divider(
              color:
                  appTheme.modoNoturno ? Color(0xffFFFFFF) : Color(0xffA45309),
              thickness: 4,
            ),
            SizedBox(height: 10),
            Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                color: appTheme.modoNoturno
                    ? Color(0xffB94F4F)
                    : Color(0xffF8CCCC),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.modoNoturno
                        ? Color(0xff693939)
                        : Color(0xffA45309),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: SwitchListTile(
                        title: Text(
                          'Modo noturno:',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            color: appTheme.modoNoturno
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        value: appTheme.modoNoturno,
                        onChanged: (value) {
                          appTheme.alternarModoNoturno(value);
                        },
                      ),
                    ),
                    Divider(
                      color: appTheme.modoNoturno
                          ? Color(0xffFFFFFF)
                          : Color(0xffA45309),
                      thickness: 5,
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'CONTA:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                                color: appTheme.modoNoturno
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Icon(
                                        Icons.auto_delete,
                                        size: 24.0,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Confirmar Exclusão',
                                        style: TextStyle(
                                          fontFamily: 'Pangolin',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: Text(
                                    'Tem certeza de que deseja excluir sua conta? Essa ação não pode ser desfeita.',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Confirmar'),
                                      onPressed: () async {
                                        await AuthService().deleteUser();
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          "/decisao",
                                          (_) => false,
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fixedSize: Size(175, 60),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.auto_delete,
                                size: 24.0,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Excluir Conta',
                                style: TextStyle(
                                  fontFamily: 'Pangolin',
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _logout(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fixedSize: Size(175, 60),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                size: 24.0,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Sair da Conta',
                                style: TextStyle(
                                  fontFamily: 'Pangolin',
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: appTheme.modoNoturno
                              ? Color(0xffFFFFFF)
                              : Color(0xffA45309),
                          thickness: 4,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.contact_support,
                              size: 24.0,
                              color: appTheme.modoNoturno
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Suporte',
                              style: TextStyle(
                                fontFamily: 'Pangolin',
                                color: appTheme.modoNoturno
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Em caso de dúvidas ou erros, entre em contato:\n jean.galdino@etec.sp.gov.br \n sarah.silva232@etec.sp.gov.br \n suporte.sospetlovers@gmail.com',
                          style: TextStyle(
                            color: appTheme.modoNoturno
                                ? Colors.white
                                : Colors.black,
                            fontFamily: 'WorkSans-ExtraLights',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
