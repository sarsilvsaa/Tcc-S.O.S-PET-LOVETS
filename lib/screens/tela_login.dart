import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste/screens/input.dart';
import 'package:teste/screens/scrollablecolumn.dart';
import 'package:teste/screens/tela_inicial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage() : super();
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _rememberMeChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8CCCC),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xffA45309),
          ),
        ),
        backgroundColor: Color(0xffF8CCCC),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Form(
          key: _formKey,
          child: ScrollableColumn(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/logopet.png',
                    width: 250,
                    height: 200,
                  ),
                  SizedBox(height: 40),
                  CustomInputField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    controller: _emailController,
                    validator: (String? email) {
                      if (email == null) {
                        return null;
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email);
                      return emailValid ? null : "Email não é válido.";
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              CustomInputField(
                keyboardType: TextInputType.visiblePassword,
                hintText: "Senha",
                obscureText: true,
                controller: _passwordController,
                validator: (String? password) {
                  if (password == null) {
                    return null;
                  }
                  if (password.length < 6) {
                    return "Senha muito curta.";
                  }
                },
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgotpassword');
                    },
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  CustomCheckbox(
                    labelText: "Lembrar de mim na próxima vez",
                    value: _rememberMeChecked,
                    onChanged: (checked) =>
                        setState(() => _rememberMeChecked = checked ?? false),
                  ),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text(
                  'ENTRAR',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffF06292),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(200, 50),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final UserCredential result = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: _emailController.value.text,
                        password: _passwordController.value.text,
                      );

                      final User? user = result.user;

                      if (user != null) {
                        _loginWithUserCollection(
                          _emailController.value.text,
                          _passwordController.value.text,
                          user.uid,
                        );
                      } else {
                        // Caso inesperado
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Erro inesperado durante a autenticação. Tente novamente.')),
                        );
                      }
                    } on FirebaseAuthException catch (exception) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Falha para autenticação: ${exception.message}')),
                      );
                    } catch (exception) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Unhandled auth error ${exception}')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginWithUserCollection(
      String email, String password, String userId) async {
    final collections = ['users', 'users-caregivers'];

    for (String collection in collections) {
      try {
        print('Tentando consultar a coleção $collection');
        final querySnapshot = await _firestore
            .collection(collection)
            .where('uid', isEqualTo: userId)
            .get();

        print('Consulta retornou ${querySnapshot.docs.length} documentos');

        if (querySnapshot.docs.isNotEmpty) {
          print('Usuário encontrado na coleção $collection');
          _navigateToHomePage(collection);
          return;
        }
      } catch (error) {
        print('Erro ao buscar usuário na coleção $collection: $error');
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ops... Encontramos um erro.')),
    );
  }

  void _navigateToHomePage(String collection) {
    if (collection == 'users') {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
    } else if (collection == 'users-caregivers') {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home_caregiver', (_) => false);
    }
  }
}
